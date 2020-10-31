class SessionsController < ApplicationController

    def new
    end

    def create
        user = User.find_by(user_name: params[:user_name])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to user_path(user)
        else
            flash[:notice] = "Invalid log in. Try again."
            redirect_to signin_path
        end
    end

    def destroy
        session.delete :user_id
        redirect_to root_path
    end

    def facebook_create
        user = User.find_or_create_by(uid: auth['uid'])
        user.facebook = true
        user.user_name = auth['info']['name']
        user.email = auth['info']['email']
        user.image = auth['info']['image']
        user.password = "test"
        user.save
        session[:user_id] = user.id
        redirect_to user_path(user)
    end
     
      private
     
    def auth
        request.env['omniauth.auth']
    end

end