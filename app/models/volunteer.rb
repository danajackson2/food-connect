class Volunteer < ApplicationRecord
    has_many :trips
    has_many :grocery_stores, through: :trips
    has_many :food_banks, through: :trips
    has_secure_password
    validates_uniqueness_of :username
    validates_length_of :name, minimum: 2, maximum: 25
end
