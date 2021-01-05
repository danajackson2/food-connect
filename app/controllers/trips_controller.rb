class TripsController < ApplicationController
    def show
        @trip = Trip.find(params[:id])
    end

    def update
        # updates volunteer_id to the session's volunteer_id
    end
end