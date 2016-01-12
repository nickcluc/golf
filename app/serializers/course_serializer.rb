class CourseSerializer < ActiveModel::Serializer
  attributes :id, :name, :street_address, :city, :state, :zip_code

  has_many :tees
end
