# frozen_string_literal: true

require_relative 'cancel'
require_relative '../utils/time'
module AcPay
  module Response
    # AcPay Payment Response
    class Pay < Cancel
      include Utils::Time
      attr_reader :pay_result,
                  :card_secret_token,
                  :card_secret_key,
                  :code_url,
                  :total_fee,
                  :auth_id_resp

      alias_method :auth_code, :auth_id_resp

      def success?
        super && pay_result == SUCCESS
      end

      def total
        total_fee.to_i
      end

      def transaction_time
        parse_time @time_end
      end

      def card
        return unless @first_6_digit_of_pan && @last_4_digit_of_pan

        "#{@first_6_digit_of_pan}******#{@last_4_digit_of_pan}"
      end
    end
  end
end
