# frozen_string_literal: true

require_relative 'notify'
module AcPay
  module Response
    # AcPay Query Response
    class Query < Notify
      attr_reader :trade_state,
                  :trade_state_desc,
                  :auth_type,
                  :pan

      alias_method :card, :pan

      def success?
        trade_state == 'SUCCESS' && pay_result == SUCCESS
      end
    end
  end
end
