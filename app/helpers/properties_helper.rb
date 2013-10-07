module PropertiesHelper
  STATUS_PROPERTIES = %w(available store reserved evaluation)
  TYPE_PROPERTIES = %w{apartment house lot country_house storefront office barn garage}
  POSITIONS = %w(front_facade rear_facade interior_facade)
  KEY_POSSESSORS = %w(owner office agent none)

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
end
