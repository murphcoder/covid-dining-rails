module RestaurantsHelper

    def alphabetize(restaurants)
        restaurants.order(name: :asc)
    end

    def yes_or_no(bool)
        if bool
            "Yes"
        else
            "no"
        end
    end

end