class Volunteer < ApplicationRecord
    has_many :trips
    has_many :grocery_stores, through: :trips
    has_many :food_banks, through: :trips
    has_secure_password
    validates_uniqueness_of :username
    validates_length_of :name, minimum: 2, maximum: 25
    validates :location, numericality: {greater_than: 0, less_than: 101}

    def self.manager
        Volunteer.find_by(username: 'Manager')
    end

    def delete_trips
        self.trips.each{|t| t.update(volunteer_id: Volunteer.manager.id)}
    end

end
