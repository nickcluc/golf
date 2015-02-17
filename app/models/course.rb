class Course < ActiveRecord::Base
  belongs_to :user
  has_many :tees
  has_many :rounds

  validates :name, :street_address, :city, :state, :zip_code, presence: true

end
