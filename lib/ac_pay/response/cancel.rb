# frozen_string_literal: true

require_relative 'base'
module AcPay
  module Response
    # AcPay Payment Response
    class Cancel < Base
      attr_reader :merchant_no,
                  :trade_type,
                  :transaction_id,
                  :out_trade_no

      alias_method :order_id, :out_trade_no
      alias_method :bank_transaction_id, :transaction_id
    end
  end
end
