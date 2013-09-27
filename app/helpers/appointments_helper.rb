module AppointmentsHelper
  MODEL = %w{Cita Informe Email Nota_Seguimiento Visita Tasacion
    LLamada_Telefonica Llamada_Seguimiento}
  STATUS = %w{avanzado cancelado completado iniciado no_iniciado esperando}

  def models
    MODEL.map{ |m| [I18n.t("appointments.model.#{m}"), m] }
  end
  def status
    STATUS.map{ |s| [s, s] }
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