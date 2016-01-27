class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.integer :zillow_id
      t.text :address
      t.text :city
      t.text :state
      t.integer :zip

      t.timestamps null: false
    end
  end
end
