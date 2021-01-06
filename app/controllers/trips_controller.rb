class TripsController < ApplicationController
    before_action :has_access?, only: [:show,:update]
    
    def has_access?
        if Trip.find(params[:id]).volunteer_id != Volunteer.find_by(username: "Manager").id && Trip.find(params[:id]).volunteer_id != fetch_user.id 
            redirect_to fetch_user
        end
    end

    def show
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
end