# frozen_string_literal: true

require_relative 'pay_base'
module AcPay
  module Request
    # AcPay Refund Request
    class PayByRedirect < PayBase

      private

      def check_data!
        raise Error, 'confirm_url is required' if confirm_url.nil?
        super
      end

      def data
        result = super
        result = result.merge(
          notify_url: result_url,
          callback_url: confirm_url
        )
        result[:layout] = '2' if mobile?
        result
      end

      def mobile?
        layout == 'mobile'
      end
    end
  end
end
