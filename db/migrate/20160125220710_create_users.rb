class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :current_city
      t.integer :bids_count, default: 0

      t.timestamps null: false
    end
  end
end
