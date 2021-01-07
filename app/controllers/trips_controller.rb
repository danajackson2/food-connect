class TripsController < ApplicationController
    before_action :has_access?, only:[:show,:update]
    
    def has_access?
        if @user.class != Volunteer || Trip.find(params[:id]).volunteer_id != Volunteer.manager.id && Trip.find(params[:id]).volunteer_id != Volunteer.find_by(username: session[:username]).id 
            redirect_to @user
        end
    end

    def new
    end

    def create
    end

    def show
        @trip = Trip.find(params[:id])
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

end