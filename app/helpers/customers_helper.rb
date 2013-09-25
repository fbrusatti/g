module CustomersHelper

  def edit_or_new_custumer_page?()
    current_page?(action: 'new') ||
    current_page?(action: 'edit', id: @customer || 0) ||
    (@customer.errors.present? if @customer.present?)
  end

  def show_custumer_page?
    current_page?(action: 'show', id: @customer || 0)
  end
end
