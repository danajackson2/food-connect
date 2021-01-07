class ApplicationController < ActionController::Base
    before_action :fetch_user
    before_action :require_login
    skip_before_action :require_login, only:[:home]

    def fetch_user
        @logged_in = logged_in?
        @users = Volunteer.all + FoodBank.all
        @user = @users.find{|user| user.username == current_username} if logged_in?
    end 

    def require_login
        unless logged_in?
            redirect_to login_path
        end
    end

    def home
        @active = Volunteer.most_active
        @food_bank_min = FoodBank.min_capacity
        @best_store = GroceryStore.best_store
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
