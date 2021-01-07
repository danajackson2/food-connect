class LoginsController < ApplicationController
    skip_before_action :require_login, only:[:create, :new]
    
    def new
        if session[:username]
            @user = get_user
            redirect_to @user
        end
    end

    def create
        @user = get_user
        if @user
            return head(:forbidden) unless @user.authenticate(params[:password])
            log_in_user(@user.username)
            redirect_to @user
        else
            flash[:errors] = ["username/password is incorrect."]
            redirect_to login_path
        end
    end

    def destroy
        session.delete :username
        redirect_to root_path
    end

    private 

    def get_user
        users = Volunteer.all + FoodBank.all
        users.find{|user| user.username == params[:username]}
    end

end