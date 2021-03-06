class Bid < ActiveRecord::Base

  validates :price, presence: true, numericality: { only_integer: true }
  validates :user_id, presence: true
  validates :house_id, presence: true

  belongs_to :user, counter_cache: true
  belongs_to :house, counter_cache: true
end
