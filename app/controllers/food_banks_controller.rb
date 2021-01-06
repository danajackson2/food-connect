class FoodBanksController < ApplicationController
    skip_before_action :require_login, only:[:create, :new]

    def new
        if session[:username]
            redirect_to FoodBank.find_by(username: session[:username])
        end
        @food_bank = FoodBank.new
    end

    def create
        @food_bank = FoodBank.create(food_bank_params)
        if @food_bank.valid?
            session[:username] = @food_bank.username
            redirect_to @food_bank
        else
            flash[:errors] = @food_bank.errors.full_messages
            redirect_to new_food_bank_path
        end
    end

    def show
        @food_bank = FoodBank.find(params[:id])
    end

    private

    def food_bank_params
        params.require(:food_bank).permit(:name, :username, :location, :password_digest)
    end

end