require 'spec_helper'
include CustomerSteps

feature "Customer" do

  background do
    @current_user = FactoryGirl.create(:user)
    login_as(@current_user, :scope => :user)
    @customer = FactoryGirl.create(:customer)
  end

  context "Creating a customer" do
     context "When surname,phone and surname are present" do
      scenario "should be allow create a customer", js: true do
        visit new_customer_path
        within new_customer_form do
          fill_in 'customer_name', :with => 'saul'
          fill_in 'customer_surname', :with => 'coria'
          fill_in 'customer_phones_mobile_phone', :with => '35841789'
        end
        customer_button_save.click
        page.should have_content(I18n.t('flash.customer', message: (I18n.t 'flash.created')))
      end
    end

    context "When surname and phone are not present" do
      scenario "should be not allow create a customer", js: true do
        visit new_customer_path
        within new_customer_form do
          fill_in 'customer_name', :with => 'saul'
        end
        customer_button_save.click
        page.should have_content(I18n.t('flash.error_create_form'))
      end
    end
  end

  context "Editing a Customer" do
    context "When name is changes to saul" do
      scenario "should be allow edit a customer", js: true do
        visit edit_customer_path(@customer)
        within edit_customer_form do
          fill_in 'customer_name', :with => 'saul'
        end
        customer_button_save.click
        page.should have_content(I18n.t('flash.customer', message: (I18n.t 'flash.updated')))
      end
    end

    context "When name is changes to blank" do
      scenario "should be not allow edit a customer", js: true do
        visit edit_customer_path(@customer)
        within edit_customer_form do
          fill_in 'customer_name', :with => " "
        end
        customer_button_save.click
        page.should have_content(I18n.t('flash.error_update_form'))
      end
    end
  end
end
