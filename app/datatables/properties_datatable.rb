class PropertiesDatatable
  include ApplicationHelper
  delegate :simple_format, :current_user, :params,
           :h, :link_to, :number_to_currency, :check_box_tag,
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
        h(prices(property, 'rent')),
        h(prices(property, 'sale')),
        link_to(short_string("#{property.owner.try(:surname_with_name)}"), property.owner),
        checkbox(property)
      ]
    end
  end

  def properties
    @properties ||= fetch_properties
  end

  def fetch_properties
    properties = Property.order("#{sort_column} #{sort_direction} nulls last")
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
    if params[:sSearch_5].present? & (params[:sSearch_5] !='null')
      rooms = params[:sSearch_5].split(",")
      properties =  properties.where("amount_rooms IN (?)",rooms)
    end
    if params[:sale_from].present? & params[:sale_to].present?
      properties = properties.where(to_sale: params[:sale_from]..params[:sale_to])
    end
    if params[:rent_from].present? & params[:rent_to].present?
      properties = properties.where(to_rent: params[:rent_from]..params[:rent_to])
    end
    if params[:sSearch_8].present?
      rent = params[:rent_from].present? && params[:rent_to].present? ? 'rent' : nil
      sale = params[:sale_from].present? && params[:sale_to].present? ? 'sale' : nil
      properties = search_money(rent, sale, params[:sSearch_8], properties)
    end
    if params[:bMyProperties] == 'true'
      properties = properties.where("properties.user_id = ?", current_user.id)
    end
    properties.includes(:money_to_rent, :money_to_sale, :owner)
  end

  def search_money(trans_rent, trans_sale, param, properties)
    if trans_sale.blank? && trans_rent.blank?
      query = "money.id = properties.m_to_rent_id OR money.id = properties.m_to_sale_id"
    else
      query = "money.id = properties.m_to_#{ trans_rent || trans_sale }_id" +
              " #{'AND money.id = properties.m_to_sale_id' if (trans_rent && trans_sale) }"
    end
    properties.joins("LEFT OUTER JOIN money ON #{query}").where("money.name = ?", param)
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def sort_column
    columns = %w[properties.id status type_property type_transaction address amount_rooms to_rent to_sale owner]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  def address(property)
    simple_format(property.pretty_address)
  end

  def prices(property, t)
    simple_format(property.pretty_price t)
  end

  def checkbox(property)
    check_box_tag 'to_list',
                  property.id,
                  params[:list_checked] =~ /#{property.id}/ ? true : false
  end
end
