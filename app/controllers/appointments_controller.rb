class AppointmentsController < ApplicationController
  respond_to :html

  def index
   respond_to do |format|
      format.html
      format.json { render json: AppointmentsDatatable.new(view_context) }
    end
  end

  def edit
     @appointment = Appointment.find(params[:id])
  end

  def update
    @appointment = Appointment.find(params[:id])
    if @appointment.update_attributes(params[:appointment])
      flash[:success] = t('flash.appointment', message: t('flash.updated'))
    end
    respond_with @appointment
  end

  def create
    @appointment = current_user.appointments.build(params[:appointment])
    if @appointment.save
      flash[:success] = t('flash.appointment', message: t('flash.created'))
    end
    respond_with @appointment
  end

  def new
    @appointment = Appointment.new
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

end
