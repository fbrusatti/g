class LandingPageDatatable
  include ApplicationHelper
  delegate :simple_format, :current_user, :params,
           :h, :link_to, :number_to_currency,
           to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: PaperTrail::Version.count,
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
        print_date(version.created_at, :date_and_time)
      ]
    end
  end

  def versions
    @versions ||= fetch_versions
  end

  def fetch_versions
    versions = PaperTrail::Version.order("#{sort_column} #{sort_direction}")
    versions = versions.page(page).per_page(per_page)
    if params[:sSearch].present?
       versions = versions.where("whodunnit ilike :search",
                                 search: "%#{params[:sSearch]}%")
    end
    if params[:sSearch_0].present?
      versions = versions.where(event: params[:sSearch_0])
    end
    if params[:sSearch_2].present?
      time = params[:sSearch_2].split(" ")
      versions = versions.where('created_at BETWEEN ? AND ?',
                                "#{time.first} 00:00:00",
                                "#{time.last} 22:59:59")
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
    klass, id = version.item_type.downcase, version.item_id
    info = I18n.t("landing.history.#{version.event}")
    info << version.primary_information
    link_to info, "#{klass.pluralize}/#{id}"
  end
end
