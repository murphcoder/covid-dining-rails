class Day < ApplicationRecord
    belongs_to :restaurant

    def weekday_string
        self.weekday.strftime("%A")
    end

    def weekday_number
        self.weekday.wday
    end

    def weekday_number=(num)
        self.weekday = Date.new(2020, 1, num.to_i + 5)
    end

    def open
        self.opening_time.strftime("%l:%M %p").strip
    end

    def open=(open_time)
        self.opening_time = DateTime.parse(open_time)
    end

    def close
        self.closing_time.strftime("%l:%M %p").strip
    end

    def close=(close_time)
        self.closing_time = DateTime.parse(close_time)
    end

    def print
        if self.closed
            [weekday_string, "CLOSED"]
        else
            [weekday_string, "From #{open} to #{close}"]
        end
    end

end
