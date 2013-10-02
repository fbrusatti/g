module CustomersHelper

  def dob(customer)
    customer.dob ? c.dob.strftime("%d/%m/%Y") : ""
  end
end
