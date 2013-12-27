class ContractsDatatable
  include ApplicationHelper
  delegate :params, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Contract.count,
      iTotalDisplayRecords: contracts.total_entries,
      aaData: data
    }
  end

private

  def data
    contracts.map do |contract|
      [
        link_to(contract.id, contract),
        renter(contract),
        property(contract),
        print_date(contract.created_at, :date)
      ]
    end
  end

  def contracts
    contracts
  end

  def contracts
    contracts = Contract.order("#{sort_column} #{sort_direction} nulls last")
    contracts = contracts.page(page).per_page(per_page)
    if params[:sSearch].present?
      contracts =
        contracts.joins("LEFT OUTER JOIN customers ON customers.id = contracts.customer_id")
      contracts =
        contracts.joins("LEFT OUTER JOIN properties ON properties.id = contracts.property_id")
      contracts = contracts.where("contracts.id =  :idsearch
                                   or customers.name ilike :search
                                   or customers.surname ilike :search
                                   or customers.id =  :idsearch
                                   or properties.id =  :idsearch
                                   or properties.address ilike :search",
                                   search: "%#{params[:sSearch]}%",
                                   idsearch: params[:sSearch].to_i)
    end
    contracts.includes(:renter, :property)
    # contracts
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def sort_column
    columns = %w[contracts.id customer_id property_id created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  def renter(contract)
    str = contract.renter ? "#{contract.renter_surname_with_name } (#{contract.renter.try(:id)})"
                          : ""
    link_to str, contract.renter
  end

  def property(contract)
    str = contract.property ? "#{contract.property_pretty_address } (#{contract.property.try(:id)})"
                          : ""
    link_to str, contract.property
  end
end
