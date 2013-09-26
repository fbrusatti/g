module PropertiesHelper
  STATUS_PROPERTIES = %w(1 2 3 4)
  TYPE_PROPERTIES = %w{apartment house lot country_house storefront office barn garage}
  POSITIONS = %w(front_facade rear_facade interior_facade)
  KEY_POSSESSORS = %w(owner office agent none)

  def status
    STATUS_PROPERTIES.map { |s| [I18n.t(".properties.status.#{s}"), s]}
  end

  def positions
    POSITIONS.map{ |p| [I18n.t(".properties.positions.#{p}"), p] }
  end

  def type_properties
    TYPE_PROPERTIES.map{ |p| [I18n.t(".properties.type_property.#{p}"), p] }
  end

  def key_possessor(form)
    options = ""
    KEY_POSSESSORS.each  do |kp|
      check_box = form.check_box :key_possessor,
                                 {:multiple => true},
                                 kp,
                                 nil
      kp_label = form.label "key_possessor_#{kp}",
                   I18n.t(".properties.key_possessor.#{kp}")
      options << check_box + kp_label
    end
    options_div = content_tag :div, options.html_safe, class: "pretty-check"
  end

  def edit_or_new_page?()
    current_page?(action: 'new') ||
    current_page?(action: 'edit', id: @property || 0) ||
    (@property.errors.present? if @property.present?)
  end

  def show_page?
    current_page?(action: 'show', id: @property || 0)
  end
end
