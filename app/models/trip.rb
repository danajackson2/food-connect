class Trip < ApplicationRecord
    belongs_to :food_bank
    belongs_to :grocery_store
    belongs_to :volunteer
    has_many :food_items, as: :owner
end
