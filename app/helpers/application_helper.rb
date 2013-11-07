module ApplicationHelper

  def errors_for(object, message=nil)
    html = ""
    unless object.errors.blank?
      html << "<div class='formErrors #{object.class.name.humanize.downcase}Errors'>\n"
      if message.blank?
        if object.new_record?
          html << "\t\t<h5> #{t("flash.error_create_form")} </h5>\n"
        else
          html << "\t\t<h5> #{t("flash.error_update_form")} </h5>\n"
        end
      else
        html << "<h5>#{message}</h5>"
      end
      html << "\t\t<ul>\n"
      object.errors.full_messages.each do |error|
        html << "\t\t\t<li>#{error}</li>\n"
      end
      html << "\t\t</ul>\n"
      html << "\t</div>\n"
    end
    html
  end

  def edit_or_new_page?(object)
    current_page?(action: 'new') ||
    current_page?(action: 'edit', id: object || 0) ||
    (object.errors.present? if object.present?)
  end

  def show_page?(object)
    current_page?(action: 'show', id: object || 0)
  end

  def index_page?(object, controller)
    current_page?(controller: controller, action: 'index')
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields",
                       data: {id: id, fields: fields.gsub("\n", "")}, remote: true)
  end

  def current_tag(tag)
    'active' if controller_path == tag
  end

  def print_date(date, format)
    date.to_s(format) if date.present?
  end

  def short_string(string)
    "#{string.slice(0..13)}#{"..." if string.size > 13}"
  end
end
