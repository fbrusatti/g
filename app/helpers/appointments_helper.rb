module AppointmentsHelper
  MODEL = %w{appointment inform email forward_note visit valuation phone_call forward_call}
  STATUS = %w{avanced canceled completed inited not_inited waited}
  ATTRIBUTES = %w{title user customer property start_date end_date description priority model status}

  def models
    MODEL.map{ |m| [I18n.t(".appointments.model.#{m}"), I18n.t(".appointments.model.#{m}")] }
  end

  def appointment_status
    STATUS.map{ |s| [I18n.t(".appointments.status.#{s}"), I18n.t(".appointments.status.#{s}")] }
  end

  def edit_customer
    unless @appointment.customer.nil? || @appointment.customer.surname.nil?
      [@appointment.customer].map(&:attributes).to_json
    end
  end

  def edit_property
    unless @appointment.property.nil? || @appointment.property.address.nil?
      [@appointment.property].map(&:attributes).to_json
    end
  end

  def show_customer(customer)
    customer.surname_with_name if customer.present?
  end

  def show_property(property)
    property.address if property.present?
  end

  def appointment_attributes
    ATTRIBUTES.map{ |a| [I18n.t("activerecord.attributes.appointment.#{a}"), a] }
  end

  def link_customer(customer)
    path, link = "",""
    if customer.present?
      path =  customer_path(customer)
      link = (customer.try(:surname_with_name)).truncate(35)
      link_to link, path, class: "note"
    else
      label_tag ""
    end
  end

  def link_property(property)
    path, link = "",""
    if property.present?
      path= property_path(property)
      if property.address?
        link= property.address.truncate(35)
      end
      link_to link, path, class: "note"
    else
      label_tag ""
    end
  end
end
