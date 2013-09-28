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
  end

  def create
    @property = current_user.properties.build(params[:property])
    if @property.save
      flash[:success] = t('flash.property', message: t('flash.created'))
    end
    respond_with @property
  end


  def show
    @property = Property.find(params[:id])
  end

  def edit
    @property = Property.find(params[:id])
  end

  def update
    @property = Property.find(params[:id])
    if @property.update_attributes(params[:property])
      flash[:success] = t('flash.property', message: t('flash.updated'))
    end
    respond_with @property
  end
end
