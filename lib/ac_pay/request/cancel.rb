# frozen_string_literal: true

require_relative 'base'
require_relative '../response/cancel'
module AcPay
  module Request
    # AcPay reverse payment request
    class Cancel < Base
      attr_accessor :order_id

      private

      def response_klass
        Response::Cancel
      end

      def service
        'unified.micropay.reverse'
      end

      def check_data!
        raise Error, 'order_id is required' if order_id.nil?
      end

      def data
        {
          **super,
          out_trade_no: order_id,
        }
      end

      def path
        'https://aio.acpay.com.tw/Refund'
      end
    end
  end
end
