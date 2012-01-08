class Venue < ActiveRecord::Base
  has_many :events
  belongs_to :user
  
  validates :name, presence: true, uniqueness: { scope: :address }
  validates :address, presence: true
  validates :user, presence: true

  def full_location
    "#{name}, #{address}"
  end

  def has_geo?
    latitude.present? && longitude.present?
  end
end
