class Review < ApplicationRecord
    belongs_to :user
    belongs_to :restaurant
    validates_presence_of :content

    def short
        self.content.truncate(20)
    end
    
end
