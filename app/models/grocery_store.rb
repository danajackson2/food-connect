class GroceryStore < ApplicationRecord
    has_many :trips
    has_many :food_banks, through: :trips
    has_many :volunteers, through: :trips
    has_many :food_items, as: :owner

    def self.best_store
        gs = Trip.all.select{|t| t.completed == true}.map{|c| c.grocery_store}
        gs.max_by{|g| gs.count(g)}
    end

    def past_trips
        self.trips.select{|t| t.completed == true}
    end
end
