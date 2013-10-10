module AppointmentsHelper
  MODEL = %w{appointment inform email forward_note visit valuation phone_call forward_call}
  STATUS = %w{avanced canceled completed inited not_inited waited}


  def models
    MODEL.map{ |m| [I18n.t(".appointments.model.#{m}"), I18n.t(".appointments.model.#{m}")] }
  end
  def appointment_status
    STATUS.map{ |s| [I18n.t(".appointments.status.#{s}"), I18n.t(".appointments.status.#{s}")] }
  end

  def edit_customer
    unless @appointment.customer.nil? || @appointment.customer.surname.nil?
      (Array.new << @appointment.customer).map(&:attributes).to_json
    end
  end

  def edit_property
    unless @appointment.property.nil? || @appointment.property.address.nil?
      (Array.new << @appointment.property).map(&:attributes).to_json
    end
  end
end