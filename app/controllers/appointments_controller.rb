class AppointmentsController < ApplicationController
  respond_to :html

  def edit
  end

  def update
  end

  def create
    @appointement = Appointment.new(params[:appointment])
    if @appointement.save
      flash[:success] = t('flash.appointment', message: t('flash.created'))
    end
    redirect_to new_appointment_path
  end

  def new
    @appointment = Appointment.new
  end

  def show
  end

  def destroy
  end
end