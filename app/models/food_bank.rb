class FoodBank < ApplicationRecord
    has_many :trips
    has_many :grocery_stores, through: :trips
    has_many :volunteers, through: :trips
    has_many :food_items, as: :owner
end
