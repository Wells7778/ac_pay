# frozen_string_literal: true

require_relative 'pay'
module AcPay
  module Response
    # AcPay Payment Response
    class Notify < Pay
      include Utils::Time
      attr_reader :out_transaction_id
    end
  end
end
