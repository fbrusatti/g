class Location < ActiveRecord::Base

  # == Attributes
  attr_accessible :city, :countri, :state

  def complete_location
    " #{city}, #{state}, #{countri}"
  end
end
