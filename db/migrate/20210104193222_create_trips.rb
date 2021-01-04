class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.integer :distance
      t.boolean :completed, default: false
      t.integer :grocery_id
      t.integer :foodbank_id
      t.integer :volunteer_id
      t.timestamps
    end
  end
end
