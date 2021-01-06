class LoginsController < ApplicationController
    skip_before_action :require_login, only:[:create, :new]
    

    def new
        if session[:username]
            redirect_to Volunteer.find_by(username: session[:username])
        end
    end

    def create
        @vol = Volunteer.find_by(username: params[:username])
        if @vol
            return head(:forbidden) unless @vol.authenticate(params[:password])
            session[:username] = @vol.username
            redirect_to @vol
        else
            flash[:errors] = ["username/password is incorrect."]
            redirect_to login_path
        end
    end

    def destroy
        session.delete :username
        redirect_to root_path
    end
end