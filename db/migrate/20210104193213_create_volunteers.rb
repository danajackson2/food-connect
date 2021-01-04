class CreateVolunteers < ActiveRecord::Migration[6.0]
  def change
    create_table :volunteers do |t|
      t.string :name
      t.integer :location
      t.string :username
      t.string :password_digest
      t.timestamps
    end
  end
end
