class FoodBanksController < ApplicationController
    skip_before_action :require_login, only:[:create, :new]
    before_action :has_access?, only:[:show]

    def has_access?
        if @user.class != FoodBank
            redirect_to @user
        end
    end

    def new
        if session[:username]
            redirect_to @user
        end
        @food_bank = FoodBank.new
    end

    def create
        @food_bank = FoodBank.create(food_bank_params)
        if @food_bank.id != nil
            session[:username] = @food_bank.username
            redirect_to @food_bank
        else
            flash[:errors] = @food_bank.errors.full_messages
            redirect_to new_food_bank_path
        end
    end

    def show
        @food_bank = FoodBank.find(params[:id])
        @grocery_stores = GroceryStore.all
        @trip = Trip.new
        if cookies[:grocery_store]
            @grocery_store = GroceryStore.find(cookies[:grocery_store].to_i)
            @food_items = GroceryStore.find(cookies[:grocery_store].to_i).food_items
        end
    end

    def data
        cookies[:grocery_store] = params[:grocery_store_id]
        redirect_to @user
    end

    private

    def food_bank_params
        params.require(:food_bank).permit(:name, :username, :location, :password, :password_confirmation)
    end

end