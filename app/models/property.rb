class Property < ActiveRecord::Base

  # == Accessors
  attr_accessible :amount_rooms, :title_to_print, :address, :description,
                  :amount_bathrooms, :lot, :meters_constructed,
                  :price, :influence_zone, :type_property, :position,
                  :type_transaction, :key_possessor, :photos_attributes,
                  :status

  # == Validations
  validates_presence_of :address

  # == Associatons
  belongs_to :user
  has_many :appointments
  has_many :photos

  accepts_nested_attributes_for :photos, allow_destroy: true
  serialize :key_possessor, Array

end
