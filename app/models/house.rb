class House < ActiveRecord::Base

  validates :zillow_id, presence: true, uniqueness: true

  has_many :bids, dependent: :destroy
  belongs_to :user, dependent: :destroy
end
