class Customer < ActiveRecord::Base

  serialize :phones, Hash

  # == Accessors
  attr_accessible :name, :surname, :dni, :phones, :phone, :mobile_phone,
                  :address, :dob, :email, :profession

  # == Validations
  validates_presence_of :name, :surname

  # == Associations
  belongs_to :user

  def surname_with_name
    "#{surname}. #{name}"
  end

end
