class PropertiesDatatable
  delegate :simple_format, :current_user, :params,
           :h, :link_to, :number_to_currency,
           to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Property.count,
      iTotalDisplayRecords: properties.total_entries,
      aaData: data
    }
  end

private

  def data
    properties.map do |property|
      [
        link_to(property.id, property),
        h(property.status),
        h(property.type_property),
        h(property.type_transaction),
        h(address(property)),
        h(property.amount_rooms),
        h(prices(property)),
        link_to("#{property.owner.try(:surname_with_name)}", property.owner)
      ]
    end
  end

  def properties
    @properties ||= fetch_properties
  end

  def fetch_properties
    properties = Property.order("#{sort_column} #{sort_direction}")
    properties = properties.page(page).per_page(per_page)
    if params[:sSearch].present?
      properties = properties.joins("LEFT OUTER JOIN customers ON customers.id = properties.owner_id")
      properties = properties.where("properties.address ilike :search
                                     or properties.influence_zone ilike :search
                                     or properties.id =  :idsearch
                                     or customers.name ilike :search
                                     or customers.surname ilike :search",
                                     search: "%#{params[:sSearch]}%",
                                     idsearch: params[:sSearch].to_i)
    end
    if params[:sSearch_1].present?
      properties = properties.where(status: params[:sSearch_1])
    end
    if params[:sSearch_2].present?
      properties = properties.where(type_property: params[:sSearch_2])
    end
    if params[:sSearch_3].present?
      properties = properties.where("type_transaction ilike :search",
                                     search: "%#{params[:sSearch_3]}%")
    end
    if params[:sSearch_5].present?
      properties = properties.where(amount_rooms: params[:sSearch_5])
    end
    if params[:bMyProperties] == 'true'
      properties = properties.joins(:user)
      properties = properties.where("users.email ilike :search",
                                     search: current_user.email)
    end
    properties.includes(:money_to_rent, :money_to_sale)
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def sort_column
    columns = %w[properties.id status type_property type_transaction address amount_rooms prices owner]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  def address(property)
    simple_format(property.pretty_address)
  end

  def prices(property)
    simple_format(property.pretty_price)
  end
end
