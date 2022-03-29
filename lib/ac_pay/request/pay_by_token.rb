# frozen_string_literal: true

require_relative 'pay_base'
module AcPay
  module Request
    # AcPay Refund Request
    class PayByToken < Base

      private

      def check_data!
        raise Error, 'cvv_prime is required' if cvv_prime.nil?
        raise Error, 'card_secret_token is required' if card_secret_token.nil?
        raise Error, 'card_secret_key is required' if card_secret_key.nil?
        super
      end

      def data
        super.merge(
          cvv_prime: cvv_prime,
          card_secret_token: card_secret_token,
          card_secret_key: card_secret_key
        )
      end
    end
  end
end
