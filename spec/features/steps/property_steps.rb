module PropertySteps
  def new_property_form
    find '#new_property'
  end

  def property_button_save
    find '.sub-header a.property-save'
  end

  def edit_property_form
    find '.edit_property'
  end
end
