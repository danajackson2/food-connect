class GroceryStore < ApplicationRecord
    has_many :trips
    has_many :food_banks, through: :trips
    has_many :volunteers, through: :trips
    has_many :food_items, as: :owner
end
