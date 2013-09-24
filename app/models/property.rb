class Property < ActiveRecord::Base

  # == Accessors
  attr_accessible :amount_rooms, :title_to_print, :address, :description,
                  :amount_bathrooms, :lot, :meters_constructed,
                  :price, :influence_zone, :type_property, :position,
                  :type_transaction

  # == Validations
  validates_presence_of :address

end
