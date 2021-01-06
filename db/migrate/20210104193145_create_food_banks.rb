class CreateFoodBanks < ActiveRecord::Migration[6.0]
  def change
    create_table :food_banks do |t|
      t.string :name
      t.string :username
      t.string :password_digest
      t.integer :location
      t.timestamps
    end
  end
end
