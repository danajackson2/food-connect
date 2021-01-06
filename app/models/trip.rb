class Trip < ApplicationRecord
    belongs_to :food_bank
    belongs_to :grocery_store
    belongs_to :volunteer
    has_many :food_items, as: :owner

    def distance(vol)
        v_to_g = (vol.location - self.grocery_store.location).abs
        g_to_f = (self.grocery_store.location - self.food_bank.location).abs
        f_to_v = (self.food_bank.location - vol.location).abs
        v_to_g + g_to_f + f_to_v
    end
end
