# frozen_string_literal: true

require 'faraday'
require 'json'
require 'nokogiri'
require 'digest'

module AcPay
  module Request
    # Base class for all AcPay::Request::* classes.
    class Base
      API_VERSION = '2.0'
      API_CHARSET = 'UTF-8'
      API_SIGN_TYPE = 'SHA-256'
      attr_accessor :config

      def initialize(params = nil)
        return unless params.is_a? Hash

        params.each do |key, value|
          send "#{key}=", value
        end
      end

      def request
        response_klass.new send_request
      end

      private

      def response_klass
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end

      def service
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end

      def check_data!
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end

      def data
        check_data!
        {
          service: service,
          version: API_VERSION,
          charset: API_CHARSET,
          sign_type: API_SIGN_TYPE,
          merchant_no: merchant_id,
          nonce_str: random_string,
        }
      end

      def random_string
        @random_string ||= SecureRandom.hex(16)
      end

      def merchant_id
        config.merchant_id
      end

      def merchant_key
        config.merchant_key
      end

      def sign
        sign_string = "#{data.sort.map { |item| item.join('=') }.join('&')}&key=#{merchant_key}"
        Digest::SHA256.hexdigest(sign_string).upcase
      end

      def sign_data
        {
          **data,
          sign: sign,
        }
      end

      def xml_item(key, value)
        "<#{key}><![CDATA[#{value}]]></#{key}>"
      end

      def xml_body
        "<xml>\n#{sign_data.map { |item| xml_item(*item) }.join("\n")}\n</xml>"
      end

      def send_request
        Faraday.post path, xml_body, 'Content-Type' => 'application/xml'
      end
    end
  end
end
