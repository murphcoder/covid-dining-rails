module RestaurantsHelper

    def alphabetize(restaurants)
        restaurants.sort_by {|restaurant| restaurant.name }
    end

    def yes_or_no(bool)
        if bool
            "Yes"
        else
            "no"
        end
    end

    def time_list
        array = []
        start_time = Time.new(2000, 01, 01, 0, 0, 0, "+00:00")
        until start_time == Time.new(2000, 01, 02, 0, 0, 0, "+00:00")
            array << start_time.strftime("%-l:%M %p")
            start_time += 900
        end
        array
    end

end