class UsersController < ApplicationController

    def index
        unless current_user.admin
            return head(:forbidden)
        end
        users = User.all
        @users = users.order(admin: :desc)
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        @user.facebook = false
        if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            render :new
        end
    end

    def show
        @user = User.find(params[:id])
        correct_user(@user)
    end

    def edit
        @user = User.find(params[:id])
        if @user.facebook
            return head(:forbidden)
        end
        correct_user(@user)
    end

    def update
        @user = User.find(params[:id])
        @user.update(user_params)
        if @user.valid?
            redirect_to user_path(@user)
        else
            render :edit
        end
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
