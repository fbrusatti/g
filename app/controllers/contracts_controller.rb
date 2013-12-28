class ContractsController < ApplicationController
  respond_to :html, :json
  before_filter :authenticate_user!

  def new
    @contract = Contract.new
    @data = {}
    @property = Property.find params[:property_token] if params[:property_token].present?
    fill_property
    fill_locator if @property
    fill_renter
  end

  def create
    @contract = current_user.contracts.build(params[:contract])
    @contract.save
    respond_with @contract
  end

  def show
    @contract = Contract.find params[:id]
  end

  def index
    respond_to do |format|
      format.html
      format.json { render json: ContractsDatatable.new(view_context) }
    end
  end

  def update
    @contract = Contract.find params[:id]
    @contract.update_attributes(params[:contract])
    respond_with @contract
  end

  private
    def fill_renter
      @data[:renter_token] = params[:renter_token]
      @data[:renter_name] = params[:renter_name].upcase if params[:renter_name].present?
      @data[:renter_dni] = params[:renter_dni] if params[:renter_dni].present?
    end

    def fill_locator
      @data[:property_token] = params[:property_token]
      if @owner = @property.owner
        @data[:locator_name] = @owner.surname_with_name.try :upcase
        @data[:locator_dni] = @owner.dni if @owner.dni.present?
      end
    end

    def fill_property
      @data[:property_address] = @property.address.upcase if @property
    end
end
