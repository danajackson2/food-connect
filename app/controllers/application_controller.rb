class ApplicationController < ActionController::Base
    before_action :fetch_user
    before_action :require_login
    skip_before_action :require_login, only:[:home]

    def fetch_user
        @logged_in = logged_in?
        @vol = Volunteer.find_by(username: current_username) if logged_in?
    end 

    def require_login
        unless logged_in?
            redirect_to login_path
        end
    end

    def home
    end

    private

    def log_in_user(username)
        session[:username] = username
    end

    def logged_in?
        !!current_username
    end

    def current_username
        session[:username]
    end

end
