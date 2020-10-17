class UsersController < ApplicationController

    def index
        unless current_user.admin
            return head(:forbidden)
        end
        @users = User.all
    end

    def new
        @user = User.new
    end

    def create
        user = User.new(user_params)
        if User.all.any? {|account| account.user_name == user.user_name}
            flash[:notice] = "User name taken. Please choose another."
            user = nil
        elsif User.all.any? {|account| account.email == user.email}
            flash[:notice] = "Email taken. Please choose another."
            user = nil
        else
            user.save
        end
        if user
            session[:user_id] = user.id
            redirect_to user_path(user)
        else
            redirect_to new_user_path
        end
    end

    def show
        @user = User.find(params[:id])
        correct_user(@user)
    end

    def edit
        @user = User.find(params[:id])
        correct_user(@user)
    end

    def update
        user = User.find(params[:id])
        user.update(user_params)
        redirect_to user_path(user)
    end

    def destroy
        user = User.find(params[:id])
        session.delete :user_id
        user.destroy
        flash[:notice] = "User deleted."
        redirect_to restaurants_path
    end

    def admin_update
        User.all.each do |user|
            if params[:users].include?(user.id.to_s)
                user.admin = true
            else
                user.admin = false
            end
            user.save
        end
        flash[:notice] = "Admin privleges updated."
        redirect_to restaurants_path
    end

    private

    def user_params
        params.require(:user).permit(:user_name, :email, :password)
    end

    def correct_user(user)
        if user != current_user && !user.admin
            return head(:forbidden)
        end
    end

end
