class Appointment < ActiveRecord::Base

  attr_accessible :title, :start_date, :end_date, :model,
                  :status, :priority, :description, :user_id, :customer_id,
                  :property_id, :owner_id, :customer_tokens, :property_tokens
  # == Associations
  belongs_to :user
  belongs_to :property
  belongs_to :customer
  belongs_to :owner, class_name: "User"

  validates_presence_of :title, :model, :user, :start_date

  # == attr reader
  attr_reader :customer_tokens, :property_tokens

  def customer_tokens=(ids)
      self.customer_id = ids
  end

  def property_tokens=(ids)
      self.property_id = ids
  end

  # == Tracking
  has_paper_trail meta: { primary_information: :information_primary }

  def information_primary
    " #{self.model}. Num: #{self.id}".slice(0..254)
  end

end
