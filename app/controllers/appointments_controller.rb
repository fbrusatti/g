class AppointmentsController < ApplicationController
  respond_to :html

  def edit
  end

  def update
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
  end

  def destroy
  end
end