# frozen_string_literal: true

require_relative 'base'
require_relative '../response/pay'
module AcPay
  module Request
    # AcPay Query Request
    class Query < Base
      attr_accessor :bank_transaction_id

      private

      def response_klass
        Response::Pay
      end

      def service
        'unified.trade.query'
      end

      def check_data!
        raise Error, 'bank_transaction_id is required' if bank_transaction_id.nil?
      end

      def data
        {
          **super,
          transaction_id: bank_transaction_id,
        }
      end

      def path
        'https://aio.acpay.com.tw/Query'
      end
    end
  end
end
