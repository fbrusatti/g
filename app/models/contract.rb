class Contract < ActiveRecord::Base
  # == Associations
  belongs_to :property
  belongs_to :renter, class_name: 'Customer'
end
