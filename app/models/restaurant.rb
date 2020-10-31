class Restaurant < ApplicationRecord
    belongs_to :author, :class_name => "User"
    has_many :reviews
    has_many :days
    has_many :users, through: :reviews
    accepts_nested_attributes_for :days
    accepts_nested_attributes_for :reviews
    validates_presence_of :name, :address
    validates_uniqueness_of :name, :address
    validate :all_days_closed

    def average_rating
        arr = self.reviews.collect {|review| review.rating}
        if arr.empty?
            0
        else
            arr.sum.to_f / arr.count.to_f
        end
    end

    def days_sorted
        self.days.sort_by {|day| day.weekday_number}
    end

    private

    def all_days_closed
        if self.days.all? {|day| day.closed}
            self.errors[:base] << "The restaurant must be open at least one day"
        end
    end

end
