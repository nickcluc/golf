class Course < ActiveRecord::Base
  belongs_to :user
  has_many :tees
  has_many :rounds
  has_many :holes
  has_many :player_rounds, through: :rounds

  HOLE_MAX = 18

  validates :name, :street_address, :city, :state, :zip_code, presence: true

  geocoded_by :full_street_address
  after_validation :geocode, if: ->(obj){ obj.street_address.present? and obj.street_address_changed? }

  def full_street_address
    [street_address, city, state, zip_code].compact.join(', ')
  end

  def full_address
    [street_address, city, state, zip_code].compact.join(' ')
  end

end
