module CustomerSteps
  def new_customer_form
    find '#new_customer'
  end

  def customer_button_save
    find '.sub-header a.customer-save'
  end

  def edit_customer_form
    find '#edit_customer_1'
  end
end
