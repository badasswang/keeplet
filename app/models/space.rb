class Space < ActiveRecord::Base
  belongs_to :user
  has_many :photos

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :space_type, presence: true
  validates :space_size, presence: true
  validates :has_moving, presence: true
  validates :list_name, presence: true
  validates :desc, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :for_car, presence: true
  validates :price, presence: true
  
end
