class Appointment < ActiveRecord::Base
  attr_accessible :title, :start_date, :end_date, :model,
   :status,:priority, :description, :user_id, :customer_id,
:property_id
  # == Associations
  belongs_to  :user
  belongs_to :property
  belongs_to :customer

  validates_presence_of :title, :start_date, :model, :user
end
