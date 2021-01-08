class FoodBank < ApplicationRecord
    has_many :trips
    has_many :grocery_stores, through: :trips
    has_many :volunteers, through: :trips
    has_many :food_items, as: :owner
    has_secure_password
    validates_length_of :name, minimum: 2, maximum: 25
    validates :location, numericality: {greater_than: 0, less_than: 101}
    validate :username_unique

    def self.min_capacity
        FoodBank.all.min_by do |f|
            f.food_items.length
        end
    end
end
