class Property < ActiveRecord::Base

  # == Accessors
  attr_accessible :amount_rooms, :title_to_print, :address, :description,
                  :amount_bathrooms, :lot, :meters_constructed,
                  :price, :influence_zone, :type_property, :position,
                  :type_transaction, :key_possessor, :photos_attributes,
                  :status, :owner_tokens, :prices, :rent_price, :sale_price,
                  :money_to_sale_attributes, :money_to_rent_attributes

  # == Validations
  validates_presence_of :address, :type_transaction

  # == Associatons
  belongs_to :owner, class_name: "Customer"
  belongs_to :user
  has_many :appointments
  has_many :photos
  has_one :money_to_sale, class_name: "Money", foreign_key: "p_sale_id"
  has_one :money_to_rent, class_name: "Money", foreign_key: "p_rent_id"

  accepts_nested_attributes_for :photos, allow_destroy: true
  accepts_nested_attributes_for :money_to_sale, reject_if: :all_blank
  accepts_nested_attributes_for :money_to_rent, reject_if: :all_blank

  serialize :key_possessor, Array
  serialize :prices, Hash

  # == Attr reader
  attr_reader :owner_tokens

  def owner_tokens=(ids)
    self.owner_id = ids
  end

end
