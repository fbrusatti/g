module PropertiesHelper
  STATUS_PROPERTIES = %w(available store reserved evaluation)
  TYPE_PROPERTIES = %w{apartment house lot country_house storefront office barn garage pasture}
  POSITIONS = %w(front_facade rear_facade interior_facade)
  KEY_POSSESSORS = %w(owner office agent none)
  TYPE_MONEYS = %w(eeuu arg)
  TYPE_TRANSACTIONS = %w(sale rent sale_rent)
  ZONES = (1..27).to_a

  def transactions_to_print
    %w(sale rent).map do |t|
     "<option value=#{t}>" + I18n.t(".properties.transactions.#{t}") + '</option>'
     end.join
  end

  def prices_for_property_pdf(property)
    label_names = []
    %w{to_sale to_rent}.each { |e| label_names << e  if (property.send(e) || 0 > 0) }
    label_names.map do |name|
      label = label_tag "property_pdf[with_#{name}]", t(".include_#{name}")
      check = check_box_tag "property_pdf[with_#{name}]", value = "1", checked = false
      content_tag :div, (label + check)
    end.join.html_safe
  end

  def zones
    ZONES.map { |z| [I18n.t("properties.zones.zone_#{z}"),
                     I18n.t("properties.zones.zone_#{z}")] } << "+"
  end

  def transactions
    TYPE_TRANSACTIONS.map { |t| [I18n.t(".properties.transactions.#{t}"),
                                 I18n.t(".properties.transactions.#{t}")]}
  end

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
    options[:value] = @property.send("#{attr_name}") unless @property.new_record?
    form.number_field attr_name, options
  end

  def prices_to_show(t)
    html, type = "", I18n.t(".properties.transactions.#{t}").downcase
    if (@property.type_transaction.downcase.include? type)
      money = t == "sale" ? @property.money_to_sale.name : @property.money_to_rent.name
      tag = label_tag type
      price = label_tag "$" + @property.send("to_#{t}").to_s + " #{money}",
                         nil, class: "pretty-input"
      html << tag + price
    end
    html.html_safe
  end

  def keys
    @property.key_possessor.map{ |kp| " #{kp}" }.join(",")
  end

  def owner
    path, link = "",""
    if @property.owner.present?
      path = customer_path(@property.owner)
      link = @property.owner.try(:surname_with_name).truncate(35)
      link_to link,path,class: "note"
    else
      label_tag ""
    end
  end

  def photos?(photos)
    @property.photos.empty? ? I18n.t(".properties.show.not_photos") : ""
  end

  def rooms
    (0..45).to_a.map { |room| [ room == 0 ? "monoambiente" : room, room ] }
  end
end
