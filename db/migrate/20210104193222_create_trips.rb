class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.integer :grocery_store_id
      t.integer :food_bank_id
      t.integer :volunteer_id
      t.timestamps
    end
  end
end
