class CustomersDatatable
  include ApplicationHelper
  delegate :simple_format, :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Customer.count,
      iTotalDisplayRecords: customers.total_entries,
      aaData: data
    }
  end

private

  def data
    customers.map do |customer|
      [
        link_to(customer.id, customer),
        link_to(short_string(customer.surname), customer),
        link_to(short_string(customer.name), customer),
        h(customer.profession),
        h(customer.address),
        phones(customer.phones),
        h(customer.email),
        h(customer.versions.first.whodunnit),
        print_date(customer.created_at, :date),
        h(date_update(customer))
      ]
    end
  end

  def date_update(customer)
    if customer.versions.last.event == "update"
      print_date(customer.versions.last.created_at, :date)
    end
  end

  def phones(phones)
    res = ""
    res << "Telefono : #{phones[:phone]} \n" unless phones[:phone].blank?
    res << "Celular : #{phones[:mobile_phone]} \n" unless phones[:mobile_phone].blank?
    simple_format res
  end

  def customers
    @customers ||= fetch_customers
  end

  def fetch_customers
    customers = Customer.order("#{sort_column} #{sort_direction}")
    customers = customers.page(page).per_page(per_page)
    if params[:sSearch].present?
      customers = customers.where("customers.id =  :idsearch or
                                  name ilike :search or surname ilike :search",
                                  search: "%#{params[:sSearch]}%",
                                  idsearch: params[:sSearch].to_i)
    end

    if params[:sSearch_7].present?
      customers = customers.where(user_id: params[:sSearch_7])
    end

    if params[:sSearch_9].present?
      time = params[:sSearch_9].split(" ")
      customers = customers.where('updated_at BETWEEN ? AND ?',
                                "#{time.first} 00:00:00",
                                "#{time.last} 22:59:59")
    end
    customers.includes(:versions)
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[customers.id surname name profession address phones
                 email user_id created_at updated_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
