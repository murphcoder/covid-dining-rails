class User < ApplicationRecord
    has_secure_password
    has_many :reviews
    has_many :restaurants, through: :reviews

    def checked
        if self.admin
            "checked"
        else
            "unchecked"
        end
    end
    
end
