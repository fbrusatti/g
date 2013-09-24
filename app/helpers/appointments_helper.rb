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
end