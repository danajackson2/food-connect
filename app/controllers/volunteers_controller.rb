class VolunteersController < ApplicationController
    def new
        @volunteer = Volunteer.new
    end

    def create
        @vol = Volunteer.create(volunteer_params)
        if @vol.valid?
            session[:volunteer_id] = @vol.id
            redirect_to @vol
        else
            flash[:errors] = @vol.errors.full_messages
            redirect_to new_volunteer_path
        end
    end

    def show
        @volunteer = Volunteer.find(params[:id])
        @trips = Volunteer.find_by(username: "Manager").trips
    end

    private

    def volunteer_params
        params.require(:volunteer).permit(:name, :username, :password, :password_confirmation)
    end
end