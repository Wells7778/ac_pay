# frozen_string_literal: true

require_relative 'base'
require_relative '../response/pay'
module AcPay
  module Request
    # AcPay Refund Request
    class Pay < Base
      attr_accessor :order_id,
                    :product,
                    :total,
                    :result_url,
                    :confirm_url,
                    :layout,
                    :prime,
                    :cvv_prime,
                    :card_secret_name,
                    :card_secret_key,
                    :remember,
                    :phone,
                    :name,
                    :email

      private

      def response_klass
        Response::Pay
      end

      def service
        'vmj'
      end

      def check_data!
        raise Error, 'order_id is required' if order_id.nil?
        raise Error, 'product is required' if product.nil?
        raise Error, 'total cant eq zero' if total.nil? || total.zero?
      end

      def data
        result = {
          **super,
          out_trade_no: order_id,
          body: product,
          total_fee: total.to_i,
        }
        result = result.merge(direct_pay_data) if prime
        result = result.merge(redirect_pay_data) unless prime
        result
      end

      def path
        config.api_host
      end

      def redirect_pay_data
        {
          notify_url: result_url,
          callback_url: confirm_url,
        }
      end

      def direct_pay_data
        result = {
          prime: prime,
        }
        result[:layout] = '2' if mobile?
        result
      end

      def mobile?
        layout == 'mobile'
      end
    end
  end
end
