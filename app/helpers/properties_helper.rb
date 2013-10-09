module PropertiesHelper
  STATUS_PROPERTIES = %w(available store reserved evaluation)
  TYPE_PROPERTIES = %w{apartment house lot country_house storefront office barn garage}
  POSITIONS = %w(front_facade rear_facade interior_facade)
  KEY_POSSESSORS = %w(owner office agent none)
  TYPE_MONEYS = %w(eeuu arg)

  def moneys
    TYPE_MONEYS.map { |m| [I18n.t(".properties.moneys.#{m}"),
                           I18n.t(".properties.moneys.#{m}")]}
  end

  def status
    STATUS_PROPERTIES.map { |s| [I18n.t(".properties.status.#{s}"),
                                 I18n.t(".properties.status.#{s}")]}
  end

  def positions
    POSITIONS.map{ |p| [I18n.t(".properties.positions.#{p}"),
                        I18n.t(".properties.positions.#{p}")] }
  end

  def type_properties
    TYPE_PROPERTIES.map{ |p| [I18n.t(".properties.type_property.#{p}"),
                              I18n.t(".properties.type_property.#{p}")] }
  end

  def key_possessor(form)
    options = ""
    KEY_POSSESSORS.each  do |kp|
      check_box = form.check_box :key_possessor,
                                 { id: "property_key_possessor_#{kp}",
                                  :multiple => true },
                                 I18n.t(".properties.key_possessor.#{kp}"),
                                 nil
      kp_label = form.label "key_possessor_#{kp}",
                   I18n.t(".properties.key_possessor.#{kp}")
      options << check_box + kp_label
    end
    options_div = content_tag :div, options.html_safe, class: "pretty-check"
  end

  def edit_owner
    unless @property.owner.nil? || @property.owner.surname.nil?
      [@property.owner].map(&:attributes).to_json
    end
  end

  def transaction_checkbox(attr_name, tname)
    checked = @property.type_transaction.try { |t| t.downcase.include? tname.downcase }
    check_box_tag attr_name, tname, checked
  end

  def transaction_price(form, attr_name)
    options = { class: "pretty-input" }
    options[:value] = @property.prices["#{attr_name}"] unless @property.new_record?
    form.number_field attr_name, options
  end

  def transaction_money(form, money)
    options = { class: "pretty-input" }
    options[:value] = @property.send("#{money}").try(:name) unless @property.new_record?
    form.select :name,
                moneys,
                {},
                options
  end
end
