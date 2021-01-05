class LoginsController < ApplicationController
    def new     
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