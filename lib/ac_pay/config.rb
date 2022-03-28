# frozen_string_literal: true

module AcPay
  # Configure the AcPay merchant
  class Config
    PRODUCTION_HOST = 'https://aiodir.acpay.com.tw'
    SANDBOX_HOST = 'https://aiodir.acpay.com.tw'

    attr_accessor :merchant_id,
                  :merchant_key

    def initialize
      @mode = :sandbox
    end

    def production!
      self.mode = :production
    end

    def sandbox?
      mode == :sandbox
    end

    def api_host
      return SANDBOX_HOST if sandbox?

      PRODUCTION_HOST
    end

    private

    attr_accessor :mode
  end
end
