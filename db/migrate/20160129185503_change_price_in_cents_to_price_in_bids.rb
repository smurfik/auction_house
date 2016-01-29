class ChangePriceInCentsToPriceInBids < ActiveRecord::Migration
  def change
    remove_column :bids, :price_in_cents, :integer
    add_column :bids, :price, :integer
  end
end
