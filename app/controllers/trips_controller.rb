class TripsController < ApplicationController
    before_action :has_access?, only:[:show,:update]
    
    def has_access?
        if @user.class != Volunteer || Trip.find(params[:id]).volunteer_id != Volunteer.manager.id && Trip.find(params[:id]).volunteer_id != Volunteer.find_by(username: session[:username]).id 
            redirect_to @user
        end
    end

    def create
        @trip = Trip.create(grocery_store_id: cookies[:grocery_store], food_bank_id: @user.id, volunteer_id: Volunteer.manager.id)
        params[:trip][:food_items].each do |id|
            FoodItem.find(id.to_i).update(owner_type: "Trip", owner_id: @trip.id)
        end
        flash[:notifications] = "Thank you for creating a trip!"
        redirect_to trips_path
    end

    def show
        @trip = Trip.find(params[:id])
        if @trip.completed == true
            redirect_to @user
        end
        @manager = Volunteer.manager
        @viewer = Volunteer.find_by(username: session[:username])
    end

    def update
        @trip = Trip.find(params[:id])
        if @trip.volunteer_id == Volunteer.manager.id
            @trip.update(volunteer_id: Volunteer.find_by(username: session[:username]).id)
        else
            @trip.update(volunteer_id: Volunteer.manager.id)
        end
        redirect_to Volunteer.find_by(username: session[:username])
    end

    def index
        @trips = Trip.all.select{|t|t.volunteer.username == "Manager"}
    end

    def complete
        @trip = Trip.find(params[:trip_id].to_i)
        @trip.food_items.each do |f|
            f.update(owner_type: "FoodBank", owner_id: @trip.food_bank.id)
        end
        @trip.update(completed: true)
        redirect_to @user
    end

end