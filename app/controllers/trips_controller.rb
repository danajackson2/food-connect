class TripsController < ApplicationController
    before_action :has_access?, only: [:show,:update]

    def has_access?
        if !session[:username] 
            redirect_to root_path
        elsif Trip.find(params[:id]).volunteer_id != Volunteer.find_by(username: "Manager").id
            redirect_to Volunteer.find_by(username: session[:username])
        end
    end

    def show
        @trip = Trip.find(params[:id])
        @manager = Volunteer.find_by(username: "Manager")
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