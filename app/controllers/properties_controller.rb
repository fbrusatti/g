class PropertiesController < ApplicationController
  respond_to :html, :json
  before_filter :authenticate_user!

  def index
    respond_to do |format|
      format.html
      if params[:q].present?
        format.json { render json: Property.where(
                                    "address ILIKE ? or properties.id =  ?",
                                    "%#{params[:q]}%", params[:q].to_i)
                                    .map(&:attributes) }
      else
        format.json { render json: PropertiesDatatable.new(view_context) }
      end
    end
  end

  def new
    @property = Property.new
    set_up_money
    @hash = { lat: -33.121732600000016,
              lng: -64.3496723}
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
    begin
      @property = Property.find params[:id]
    rescue ActiveRecord::RecordNotFound => e
      return redirect_to properties_path
    end
    @versions = @property.versions
    @hash = { lat: @property.latitude,
              lng: @property.longitude,
              infowindow: render_to_string(partial: 'map_info',
                                           formats: [:html],
                                           layout: false)
            }
    respond_to do |format|
      format.html
      format.json { render json: PropertyVersionDatatable.new(view_context, @versions) }
    end
  end

  def edit
    @property = Property.find(params[:id])
    set_up_money
    @hash = { lat: @property.latitude,
              lng: @property.longitude,
              infowindow: render_to_string(partial: 'map_info',
                                           formats: [:html],
                                           layout: false)
            }
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

  def geocoding
    result = Geocoder.search(params[:address]).as_json
    result = result[0]["data"]["geometry"]["location"]
    render json: result
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

    def user_for_paper_trail
      current_user.surname_with_name
    end
end
