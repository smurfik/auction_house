class House < ActiveRecord::Base

  validates :zillow_id, presence: true, uniqueness: true

  has_many :bids, dependent: :destroy
end
