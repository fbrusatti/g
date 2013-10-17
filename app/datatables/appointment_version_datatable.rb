class AppointmentVersionDatatable
  include ApplicationHelper
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
        print_date(version.created_at, :date_and_time),
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
                               (Time.zone.parse(time.first)).beginning_of_day.to_s(:db),
                                (Time.zone.parse(time.last)).end_of_day.to_s(:db))
    end
    # if params[:sSearch].present?
    #    versions = versions.where("whodunnit ilike :search",
    #                              search: "%#{params[:sSearch]}%")
    # end
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
    return "#{i18n("create")} #{changes[:title].last}" if version.event=="create"
    r=""
    changes.each do |k|
      key = I18n.t("activerecord.attributes.appointment.#{k[0]}")
      r <<  messages(k[1].first, k[1].last, key)
    end
    simple_format r
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

  def i18n(data)
    "#{I18n.t("appointments.datatables.#{data}")} "
  end
end
