class ChangePriceInCentsToPriceInBids < ActiveRecord::Migration
  def change
    rename_column :bids, :price_in_cents, :price
  end
end
