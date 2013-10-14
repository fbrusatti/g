class CustomersController < ApplicationController
  respond_to :html

  before_filter :authenticate_user!


  def index
    respond_to do |format|
      format.html
      if params[:q].present?
        format.json { render :json => Customer.where("surname ILIKE ?",
                                      "%#{params[:q]}%").map(&:attributes)}
      else
        @users = User.all
        format.json { render json: CustomersDatatable.new(view_context) }
      end
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
    @versions = @customer.versions
    @users = User.all
    respond_to do |format|
      format.html
      format.json { render json: CustomerVersionsDatatable.new(view_context, @versions) }
    end
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

  def user_for_paper_trail
    current_user.email
  end

end
