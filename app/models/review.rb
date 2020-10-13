class Review < ApplicationRecord
    belongs_to :user
    belongs_to :restaurant

    def short
        self.content.truncate(20)
    end
    
end
