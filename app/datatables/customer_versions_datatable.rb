class CustomerVersionsDatatable
  include ApplicationHelper
  delegate :simple_format, :current_user, :params, :h,
           :link_to, :number_to_currency, to: :@view

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
        changes(version),
        h(version.whodunnit),
        print_date(version.created_at, :date_and_time)
      ]
    end
  end

  def versions
    fetch_versions
  end

  def fetch_versions
    versions = @versions.reorder("#{sort_column} #{sort_direction}")
    versions = versions.page(page).per_page(per_page)

    if params[:sSearch_0].present?
      versions = versions.where("object_changes ilike :search",
                                     search: "%#{params[:sSearch_0]}%")
    end
    if params[:sSearch_1].present?
      versions = versions.where(whodunnit: params[:sSearch_1])
    end
    if params[:sSearch_2].present?
      time = params[:sSearch_2].split(" ")
      versions = versions.where('created_at BETWEEN ? AND ?',
                                "#{time.first} 00:00:00",
                                "#{time.last} 22:59:59")
    end

    versions
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[object_changes  whodunnit created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "asc" ? "desc" : "asc"
  end

  def changes(version)
    changes = version.changeset
    return customer_create(changes) if version.event == "create"
    res = " "
    changes.each do |k|
      if k[0]=="phones"
        phone_b, phone_a = k[1].first["phone"],
                           k[1].last["phone"]
        mobile_b, mobile_a = k[1].first["mobile_phone"],
                             k[1].last["mobile_phone"]
        if phone_b != phone_a
          name_attr = I18n.t("customers.datatables.#{k[1].first.keys.first}")
          res << messages(phone_b, phone_a, name_attr)
        end
        if mobile_b != mobile_a
           name_attr = I18n.t("customers.datatables.#{k[1].first.keys.last}")
          res << messages(mobile_b, mobile_a, name_attr)
        end
      else
        name_attr = I18n.t("customers.datatables.#{k[0]}")
        before = k[1].first
        after = k[1].last
        before, after = k[1].first.to_s, k[1].last.to_s if k[0]=="dob"
        res << messages(before, after, name_attr)
      end
    end
    simple_format res
  end

  def customer_create(c)
    simple_format "#{i18n("create")} #{c[:name].last} #{c[:surname].last}"
  end

  def i18n(data)
    "#{I18n.t("customers.datatables.#{data}")} "
  end

  def messages(before, after, name_attr)
    res = ""
    if before.blank?
      res << "#{i18n("add")} #{name_attr.upcase} : #{after} \n"
    elsif after.blank?
      res << "#{i18n("delete")} #{name_attr.upcase} : #{before} \n"
    else
      res << "#{i18n("change")} #{name_attr.upcase} : #{before} a #{after}\n"
    end
    res
  end
end
