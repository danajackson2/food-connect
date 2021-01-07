class VolunteersController < ApplicationController
    skip_before_action :require_login, only:[:create, :new]
    before_action :has_access?, only:[:show, :edit, :update, :destroy]

    def has_access?
        if @user.class != Volunteer
            redirect_to @user
        end
    end

    def new
        if session[:username]
            redirect_to @user
        end
        @volunteer = Volunteer.new
    end

    def create
        @vol = Volunteer.create(volunteer_params)
        if @vol.id != nil
            session[:username] = @vol.username
            redirect_to @vol
        else
            flash[:errors] = @vol.errors.full_messages
            redirect_to new_volunteer_path
        end
    end

    def show
        @volunteer = Volunteer.find(params[:id])
        @trips = Volunteer.manager.trips.select{|t| t.completed == false}.sort_by{|t| t.distance(@volunteer)}
        @my_trips = @volunteer.trips.select{|trip| trip.completed == false}
        @past_trips = @volunteer.trips.select{|trip| trip.completed == true}
    end

    def edit
        @vol = Volunteer.find(params[:id])
    end

    def update
        @vol = Volunteer.find(params[:id])
        @vol.update(name: params[:volunteer][:name])
        if @vol.valid?
            redirect_to @vol
        else
            flash[:errors] = @vol.errors.full_messages
            redirect_to edit_volunteer_path
        end

    end

    def destroy
        @vol = Volunteer.find(params[:id])
        @vol.delete_trips
        @vol.destroy
        session.delete :username
        redirect_to root_path
    end

    private

    def volunteer_params
        params.require(:volunteer).permit(:name, :username, :location, :password, :password_confirmation)
    end
end