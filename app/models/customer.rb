class Customer < ActiveRecord::Base

  # == Accessors
  attr_accessible :name, :surname, :dni, :phones,
                  :address, :dob, :email, :profession

  # == Validations
  validates_presence_of :name, :surname

  def surname_with_name
    "#{surname}. #{name}"
  end
end
