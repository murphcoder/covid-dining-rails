class Restaurant < ApplicationRecord
    has_many :reviews
    has_many :days
    has_many :users, through: :reviews

    def average_rating
        arr = self.reviews.collect {|review| review.rating}
        if arr.empty?
            0
        else
            arr.sum.to_f / arr.count.to_f
        end
    end

end
