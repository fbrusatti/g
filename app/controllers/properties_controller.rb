class PropertiesController < ApplicationController
  respond_to :html
  before_filter :authenticate_user!

  def index
    respond_to do |format|
      format.html { @properties = Property.all}
      format.json { render :json => Property.where("address ILIKE ?", "%#{params[:q]}%").map(&:attributes)}
    end
  end

  def new
    @property = Property.new
    set_up_money
  end

  def create
    @property = current_user.properties.build(params[:property])
    type_transaction(params)
    if @property.save
      flash[:success] = t('flash.property', message: t('flash.created'))
    else
      set_up_money
    end
    respond_with @property
  end

  def show
    @property = Property.find(params[:id])
  end

  def edit
    @property = Property.find(params[:id])
    set_up_money
  end

  def update
    @property = Property.find(params[:id])
    type_transaction(params)

    if @property.update_attributes(params[:property])
      flash[:success] = t('flash.property', message: t('flash.updated'))
    else
      set_up_money
    end
    respond_with @property
  end

  private
    def type_transaction(params)
      text = "#{params[:to_sale]} #{params[:to_rent]}".strip
      @property.type_transaction = text
    end

    def set_up_money
      @property.build_money_to_sale if @property.money_to_sale.nil?
      @property.build_money_to_rent if @property.money_to_rent.nil?
    end
end
