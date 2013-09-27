class Customer < ActiveRecord::Base

  serialize :phones, Hash

  # == Accessors
  attr_accessible :name, :surname, :dni, :phones, :phone, :mobile_phone,
                  :address, :dob, :email, :profession

  # == Validations
  validates_presence_of :name, :surname
  validates_format_of :email, { :allow_blank => true, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

  # == Associations
  belongs_to :user
  has_many :appointments
  has_many :properties

  def surname_with_name
    "#{surname}. #{name}"
  end

  def customer_tokens=(ids)
      self.property_id = ids
  end


end
