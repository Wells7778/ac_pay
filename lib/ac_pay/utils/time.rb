# frozen_string_literal: true

module AcPay
  module Utils
    # Time Helper
    module Time
      TIMEZONE = '+8'
      # time string format: yyyyMMddhhmmss
      def parse_time(time_string)
        DateTime.new(
          time_string[0, 4].to_i,
          time_string[4, 2].to_i,
          time_string[6, 2].to_i,
          time_string[8, 2].to_i,
          time_string[10, 2].to_i,
          time_string[12, 2].to_i,
          TIMEZONE
        )
      end
    end
  end
end
