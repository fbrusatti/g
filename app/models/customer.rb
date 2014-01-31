class Customer < ActiveRecord::Base
  # == Scopes
  default_scope { where active: true }

  serialize :phones, Hash
  has_paper_trail meta: { primary_information: :information_primary }

  # == Accessors
  attr_accessible :name, :surname, :dni, :phones, :phone, :mobile_phone,
                  :address, :dob, :email, :profession, :description, :active

  # == Validations
  validates_presence_of :name, :surname
  validates_format_of :email, { :allow_blank => true, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validate :presence_phone_or_mobile

  # == Associations
  belongs_to :user
  has_many :appointments
  has_many :properties, foreign_key: "owner_id"

  def surname_with_name
    "#{surname}. #{name}"
  end

  def customer_tokens=(ids)
      self.property_id = ids
  end

  def pretty_phones
    "#{self.phones[:phone]} \n #{self.phones[:mobile_phone]}"
  end

  def information_primary
    info = " Cliente #{self.surname_with_name}. Num cliente:#{self.id}".slice(0..250)
    info << "#{info} /n" if self.active.blank?
    info
  end

  private
    def presence_phone_or_mobile
      if phones[:phone].blank? && phones[:mobile_phone].blank?
        errors.add(:phones, I18n.t('activerecord.models.errors.message_phones'))
      end
    end
end
