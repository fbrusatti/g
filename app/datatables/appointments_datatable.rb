class AppointmentsDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Appointment.count,
      iTotalDisplayRecords: appointments.total_entries,
      aaData: data
    }
  end

private

  def data
    appointments.map do |a|
      [
        link_to(a.title, a),
        h(a.user.surname_with_name),
        h(a.model),
        h(a.status),
        h("#{a.start_date.strftime("%d/%m/%Y %I:%M") if a.start_date}"),
        h(a.priority),
        link_to("#{a.customer.surname_with_name if a.customer}", a.customer),
        link_to("#{a.property.address if a.property}", a.property)
      ]
    end
  end

  def appointments
    @appointments ||= fetch_appointments
  end

  def fetch_appointments
    appointments = Appointment.order("#{sort_column} #{sort_direction}")
    appointments = appointments.page(page).per_page(per_page)
    if params[:sSearch].present?
      # appointments = appointments.where("title ilike :search", search: "%#{params[:sSearch]}%")
      appointments = ((appointments.joins(:customer)).joins(:property)).where(
        "title ilike :search
         or customers.surname ilike :search
         or properties.address ilike :search", search: "%#{params[:sSearch]}%")
    end
    if params[:sSearch_5].present?
      appointments = appointments.where(:priority =>params[:sSearch_5])
    end
    if params[:sSearch_3].present?
      appointments = appointments.where(:status =>params[:sSearch_3])
    end
    if params[:sSearch_2].present?
      appointments = appointments.where(:model =>params[:sSearch_2])
    end
    if params[:sSearch_1].present?
      appointments = (appointments.joins(:user)).where(users: {:id =>params[:sSearch_1]})
    end
    if params[:sSearch_4].present?
      time = params[:sSearch_4].split(" ")
      appointments = appointments.where('created_at BETWEEN ? AND ?',
                                "#{time.first} 00:00:00",
                                "#{time.last} 22:59:59")
    end
    if params[:dateType].present?
      appointments = filterDate(appointments, params[:dateType])
    end
    appointments
  end


  def filterDate (ap, dateType)
    if dateType=="week"
        ap = ap.where('start_date BETWEEN ? AND ?',
          (get_first_monday(DateTime.now)).beginning_of_day.to_s(:db),
          (get_next_saturday(DateTime.now)).end_of_day.to_s(:db))

      elsif dateType=="today"
        ap = ap.where('start_date BETWEEN ? AND ?',
          DateTime.now.beginning_of_day.to_s(:db),
          DateTime.now.end_of_day.to_s(:db))

      elsif dateType=="month"
        ap = ap.where('start_date BETWEEN ? AND ?',
          DateTime.now.beginning_of_month.to_s(:db),
          DateTime.now.end_of_month.to_s(:db))
    end
    ap
  end

  def get_first_monday(start_date)
    day = start_date
    until day.monday? do
      day -= 1.day
    end
    day
  end

  def get_next_saturday(start_date)
    day = start_date
    until day.saturday? do
      day += 1.day
    end
    day
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[title user model status start_date priority customer_id property_id]
    columns[params[:iSortCol_0].to_i]
   end

  def sort_direction
     params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end