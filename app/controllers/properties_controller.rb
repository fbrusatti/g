class PropertiesController < ApplicationController
  respond_to :html
  before_filter :authenticate_user!

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

  def index
  end

  def show
    @property = Property.find(params[:id])
  end

  def edit
    @property = Property.find(params[:id])
  end

  def update
  end
end
