class Space < ActiveRecord::Base
  belongs_to :user
  has_many :photos
  has_many :bookings
  has_many :reviews

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :space_type, presence: true
  validates :space_size, presence: true
  validates :list_name, presence: true
  validates :desc, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :price, presence: true

  def show_first_photo(size)
    if self.photos.length == 0
      'http://www.clker.com/cliparts/Z/b/7/G/y/q/simple-orange-house-md.png'
    else
      self.photos[0].image.url(size)
    end
  end

  def average_rating
    reviews.count == 0 ? 0 : reviews.average(:star)
  end

end
