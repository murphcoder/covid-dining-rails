module ReviewsHelper

    def editable_reviews(restaurant, user=current_user)
        restaurant.reviews.select {|review| review.user == user}
    end

    def has_written_review?(restaurant)
        restaurant.reviews.any? {|review| review.user == current_user}
    end

end
