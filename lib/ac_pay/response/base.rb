# frozen_string_literal: true

require 'nokogiri'
module AcPay
  module Response
    # Base class for all AcPay::Response::* classes.
    class Base
      SUCCESS = '0'
      attr_reader :result_code,
                  :status,
                  :message,
                  :err_code,
                  :err_msg

      def initialize(response)
        @raw = response.body&.force_encoding('utf-8') || ''
        @xml = Nokogiri::XML(@raw)
        parse_xml
      end

      def success?
        status == SUCCESS && result_code == SUCCESS
      end

      alias_method :error_message, :err_msg

      private

      def parse_xml
        @xml.search('xml').children.each do |node|
          next if node.name == 'text'

          instance_variable_set :"@#{node.name}", node.text
        end
      end
    end
  end
end
