# frozen_string_literal: true

require_relative 'base'
require_relative '../response/refund'
module AcPay
  module Request
    # AcPay Refund Request
    class Refund < Base
      attr_accessor :bank_transaction_id,
                    :refund_id,
                    :total

      private

      def response_klass
        Response::Refund
      end

      def service
        'unified.trade.refund'
      end

      def check_data!
        raise Error, 'bank_transaction_id is required' if bank_transaction_id.nil?
        raise Error, 'refund_id is required' if refund_id.nil?
        raise Error, 'total is required' if total.nil? || total.zero?
      end

      def data
        {
          **super,
          transaction_id: bank_transaction_id,
          out_refund_no: refund_id,
          total_fee: total.to_i,
          refund_fee: total.to_i,
        }
      end

      def path
        'https://aio.acpay.com.tw/Refund'
      end
    end
  end
end
