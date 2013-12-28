class Contract < ActiveRecord::Base
  # == Associations
  belongs_to :user
  belongs_to :property
  belongs_to :renter, foreign_key: 'customer_id', class_name: 'Customer'

  attr_accessible :raw_contract, :renter_token, :property_token

  # == Attr reader
  attr_reader :renter_token, :property_token

  # == Delegates
  delegate :surname_with_name, to: :renter, prefix: true, allow_nil: true
  delegate :pretty_address, to: :property, prefix: true, allow_nil: true

  def renter_token=(id)
    self.customer_id = id
  end

  def property_token=(id)
    self.property_id = id
  end

end
