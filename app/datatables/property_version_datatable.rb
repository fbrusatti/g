class PropertyVersionDatatable
  delegate :simple_format, :current_user, :params,
           :h, :link_to, :number_to_currency,
           to: :@view

  def initialize(view, versions)
    @view = view
    @versions = versions
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: @versions.count,
      iTotalDisplayRecords: versions.total_entries,
      aaData: data
    }
  end

private

  def data
    versions.map do |version|
      [
        changes_tohuman(version),
        h(version.whodunnit),
        h(version.created_at)
      ]
    end
  end

  def versions
    fetch_versions
  end

  def fetch_versions
    versions = @versions.reorder("#{sort_column} #{sort_direction}")
    versions = versions.page(page).per_page(per_page)
    if params[:sSearch].present?
       versions = versions.where("whodunnit ilike :search",
                                 search: "%#{params[:sSearch]}%")
    end
    versions
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def sort_column
    columns = %w[event whodunnit created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "asc" ? "desc" : "asc"
  end

  def changes_tohuman(version)
    changes = version.changeset
    return "Creado" if version.event == "create"
    r=""
    changes.each do |k|
      key = I18n.t("activerecord.attributes.property.#{k[0]}")
      r << "Cambio #{key}, de #{k[1].first} a #{k[1].last} \n" unless k[0]=="prices"
      if k[0]=="prices"
        sale_b, sale_a = k[1].first[:to_sale], k[1].last[:to_sale]
        rent_b, rent_a = k[1].first[:to_rent], k[1].last[:to_rent]
        r << "Cambio #{key} de vta, de $#{sale_b} a $#{sale_a} \n" if sale_b != sale_a
        r << "Cambio #{key} de alq, de $#{rent_b} a $#{rent_a} \n" if rent_b != rent_a
      end
    end
    simple_format r
  end
end
