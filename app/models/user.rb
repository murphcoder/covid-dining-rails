class User < ApplicationRecord
    has_secure_password
    has_many :reviews
    has_many :restaurants, through: :reviews
    validates_presence_of :user_name, :email, :password, unless: :facebook
    validates_uniqueness_of :user_name, :email, unless: :facebook
    validate :email_format

    def checked
        if self.admin
            "checked"
        else
            "unchecked"
        end
    end

    def email_format
        if self.email !~ /.*[@].*[.].*/ && !self.email.empty?
            self.errors[:email] << "address is improperly formatted"
        end
    end

end