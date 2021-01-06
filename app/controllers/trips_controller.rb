class TripsController < ApplicationController
    before_action :has_access?, only: [:show,:update]
    
    def has_access?
        if Trip.find(params[:id]).volunteer_id != Volunteer.find_by(username: "Manager").id && Trip.find(params[:id]).volunteer_id != fetch_user.id 
            redirect_to fetch_user
        end
    end

    def show
        @distance = distance
        @trip = Trip.find(params[:id])
        @manager = Volunteer.find_by(username: "Manager")
        @viewer = fetch_user
    end

    def update
        @trip = Trip.find(params[:id])
        if @trip.volunteer_id == Volunteer.find_by(username: "Manager").id
            @trip.update(volunteer_id: Volunteer.find_by(username: session[:username]).id)
        else
            @trip.update(volunteer_id: Volunteer.find_by(username: "Manager").id)
        end
        redirect_to Volunteer.find_by(username: session[:username])
    end

    private 

    def distance
        fetch_user.class == Volunteer
        v_to_g = (fetch_user.location - Trip.find(params[:id]).grocery_store.location).abs
        g_to_f = (Trip.find(params[:id]).grocery_store.location - Trip.find(params[:id]).food_bank.location).abs
        f_to_v = (Trip.find(params[:id]).food_bank.location - fetch_user.location).abs
        v_to_g + g_to_f + f_to_v
    end
end