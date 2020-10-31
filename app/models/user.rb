class User < ApplicationRecord
    has_secure_password
    has_many :reviews
    has_many :restaurants, through: :reviews
    validates_presence_of :user_name, :email, :password, unless: :facebook
    validates_uniqueness_of :user_name, :email, unless: :facebook

    def checked
        if self.admin
            "checked"
        else
            "unchecked"
        end
    end

end