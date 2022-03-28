# frozen_string_literal: true

require_relative 'notify'
module AcPay
  module Response
    # AcPay Payment Response
    class Refund < Notify
      attr_reader :out_refund_no,
                  :refund_id,
                  :refund_fee

      alias_method :refund, :refund_fee

      def success?
        status == SUCCESS && result_code == SUCCESS
      end
    end
  end
end
