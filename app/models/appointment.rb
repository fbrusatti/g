class Appointment < ActiveRecord::Base
  attr_accessible :title, :start_date, :end_date, :model,
   :status,:priority, :description, :user_id, :customer_id,
:property_id, :owner_id
  # == Associations
  belongs_to :user , foreign_key: "user_id"
  belongs_to :property
  belongs_to :customer
  belongs_to :owner, foreign_key: "owner_id"

  validates_presence_of :title, :start_date, :model, :user
end
