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
    begin
      @appointment = Appointment.find params[:id]
    rescue ActiveRecord::RecordNotFound => e
      return redirect_to appointments_path
    end
    @versions = @appointment.versions
    @users = User.all
    respond_to do |format|
      format.html
      format.json { render json: AppointmentVersionDatatable.new(view_context, @versions) }
    end
  end

  def user_for_paper_trail
    current_user.surname_with_name
  end

end
