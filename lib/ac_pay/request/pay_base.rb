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
                    :card_secret_token,
                    :card_secret_key,
                    :remember,
                    :phone,
                    :name,
                    :email,
                    :remember

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
        raise Error, 'phone, name, email is required' if remember && (phone.nil? || name.nil? || email.nil?)
      end

      def data
        result = {
          **super,
          out_trade_no: order_id,
          body: product,
          total_fee: total.to_i,
        }
        if remember
          result[:remember] = 'Y'
          result[:card_holder_phone_number] = phone
          result[:card_holder_name] = name
          result[:card_holder_email] = email
        end
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
          result[:layout] = '2' if mobile?,
        }
      end

      def direct_pay_data
        {
          prime: prime,
        }
      end

      def mobile?
        layout == 'mobile'
      end
    end
  end
end
