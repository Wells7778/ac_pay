# frozen_string_literal: true

require_relative 'pay_base'
module AcPay
  module Request
    # AcPay Refund Request
    class PayByPrime < PayBase
      private

      def check_data!
        raise Error, 'prime' if prime.nil?
        super
      end

      def data
        result = super
        if remember
          result[:remember] = 'Y'
          result[:card_holder_phone_number] = phone
          result[:card_holder_name] = name
          result[:card_holder_email] = email
        end
        result = result.merge(prime: prime)
        result
      end
    end
  end
end
