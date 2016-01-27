class Bid < ActiveRecord::Base

  validates :price_in_cents, presence: true, numericality: { only_integer: true }
  validates :user_id, presence: true

  belongs_to :user, counter_cache: true
  belongs_to :house, counter_cache: true
end
