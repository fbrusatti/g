class Appointment < ActiveRecord::Base
  # == Scopes
  default_scope { where active: true }

  # == Accessors
  attr_accessible :title, :start_date, :end_date, :model,
                  :status, :priority, :description, :user_id, :customer_id,
                  :property_id, :owner_id, :customer_tokens, :property_tokens,
                  :active
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
    info = " #{self.model}. Num: #{self.id}".slice(0..250)
    info << "#{info} /n" if self.active.blank?
    info
  end

end
