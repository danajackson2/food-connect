class VolunteersController < ApplicationController
    skip_before_action :require_login, only:[:create, :new]

    def new
        if session[:username]
            redirect_to Volunteer.find_by(username: session[:username])
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
        @trips = Volunteer.manager.trips
        @mytrips = @volunteer.trips
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