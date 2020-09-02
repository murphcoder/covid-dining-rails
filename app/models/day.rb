class Day < ApplicationRecord
    belongs_to :restaurant

    def weekday_string
        self.weekday.strftime("%A")
    end

    def weekday_number
        self.weekday.wday
    end

    def weekday_number=(num)
        self.weekday = Date.new(2020, 1, num + 5)
    end

    def open
        self.opening_time.strftime("%l:%M %p")
    end

    def close
        self.closing_time.strftime("%l:%M %p")
    end

end
