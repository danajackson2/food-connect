class Volunteer < ApplicationRecord
    has_many :trips
    has_many :grocery_stores, through: :trips
    has_many :food_banks, through: :trips
    has_secure_password
    validates_length_of :name, minimum: 2, maximum: 25
    validates :location, numericality: {greater_than: 0, less_than: 101}

    def self.manager
        Volunteer.find_by(username: 'Manager')
    end

    def self.most_active
        Volunteer.all.select{|v| v.username != "Manager"}.max_by{|v| v.past_trips.length}
    end

    def delete_trips
        self.trips.each{|t| t.update(volunteer_id: Volunteer.manager.id)}
    end

    def past_trips
        self.trips.select{|t| t.completed == true}
    end

end
