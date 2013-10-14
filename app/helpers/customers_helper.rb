module CustomersHelper
  ATTRIBUTES = %w{ name surname dni phones address dob email profession }

  def customer_attributes
    ATTRIBUTES.map{ |a| [I18n.t("customers.datatables.#{a}"), a] }
  end

  def dob(customer)
    customer.dob ? customer.dob.strftime("%d/%m/%Y") : ""
  end
end
