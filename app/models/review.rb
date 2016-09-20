class Review < ActiveRecord::Base
  belongs_to :space
  belongs_to :user

  validates :star, presence: true
end
