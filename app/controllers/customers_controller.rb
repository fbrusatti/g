class CustomersController < ApplicationController
  respond_to :html

  before_filter :authenticate_user!


  def index
    respond_to do |format|
      format.html { @customers = Customer.all}
      format.json { render :json => Customer.where("surname ILIKE :search or name ILIKE :search", search: "%#{params[:q]}%").map(&:attributes)}
    end
  end

  def new
    @customer = Customer.new
  end


  def create
    @customer = current_user.customers.build(params[:customer])
    if @customer.save
      flash[:success] = t('flash.customer', message: t('flash.created'))
    end
    respond_with @customer
  end

  def show
  @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(params[:customer])
      flash[:success] = t('flash.customer', message: t('flash.updated'))
    end
    respond_with @customer
  end
end
