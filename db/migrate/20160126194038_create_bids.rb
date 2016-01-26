class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :price_in_cents
      t.integer :user_id
      t.integer :house_id

      t.timestamps null: false
    end
  end
end
