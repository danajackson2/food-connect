class VolunteersController < ApplicationController
    before_action :has_access?, only: [:show,:edit,:destroy]

    def has_access?
        if !session[:username] 
            redirect_to root_path
        elsif Volunteer.find_by(username: session[:username]).id != params[:id].to_i
            redirect_to Volunteer.find_by(username: session[:username])
        end
    end
    
    def new
        @volunteer = Volunteer.new
    end

    def create
        @vol = Volunteer.create(volunteer_params)
        if @vol.valid?
            session[:username] = @vol.username
            redirect_to @vol
        else
            flash[:errors] = @vol.errors.full_messages
            redirect_to new_volunteer_path
        end
    end

    def show
        @volunteer = Volunteer.find(params[:id])
        @trips = Volunteer.find_by(username: "Manager").trips
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
        @vol.destroy
        session.delete :username
        redirect_to root_path
    end

    private

    def volunteer_params
        params.require(:volunteer).permit(:name, :username, :password, :password_confirmation)
    end
end