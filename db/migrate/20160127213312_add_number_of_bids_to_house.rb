class AddNumberOfBidsToHouse < ActiveRecord::Migration
  def change
    add_column :houses, :bids_count, :integer
  end
end
