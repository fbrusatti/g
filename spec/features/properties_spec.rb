require 'spec_helper'
include PropertySteps

feature "Property" do

  background do
    @current_user = FactoryGirl.create(:user)
    login_as(@current_user, scope: :user)
  end

  context "Creating a property" do
    scenario "User creates a new property", js: true do
      visit new_property_path
      within new_property_form do
        fill_in 'property_address', with: 'Rivadavia 241'
        fill_in 'property_description', with: 'Exelente casa para fiestas o empresas'
        page.select '3', from: 'property_amount_rooms'
        page.select '2', from: 'property_amount_bathrooms'
        fill_in 'property_lot', with: 200
        fill_in 'property_meters_constructed', with: 150
        fill_in 'property_title_to_print', with: 'casa centrica, exelente nrm ref: 895'
        fill_in 'property_influence_zone', with: 'centro'
        page.select 'Frente', from: 'property_position'
        page.select 'Casa', from: 'property_type_property'
        page.check('property_key_possessor_owner')
        page.check('property_key_possessor_office')
      end
      property_button_save.click
      page.should have_content I18n.t('flash.property',
                                       message: I18n.t('flash.created'),
                                       locale: 'es')
    end
    context "When Address is not present" do
      scenario "should be not allow create a property", js: true do
        visit new_property_path
        within new_property_form do
          fill_in 'property_description', with: 'Exelente casa para fiestas o empresas'
          page.select '3', from: 'property_amount_rooms'
          page.select '2', from: 'property_amount_bathrooms'
          fill_in 'property_lot', with: 200
          fill_in 'property_meters_constructed', with: 150
          fill_in 'property_title_to_print', with: 'casa centrica, exelente nrm ref: 895'
          fill_in 'property_influence_zone', with: 'centro'
          page.select 'Frente', from: 'property_position'
          page.select 'Casa', from: 'property_type_property'
          page.check('property_key_possessor_owner')
          page.check('property_key_possessor_office')
        end
        property_button_save.click
        page.should have_content I18n.t('flash.error_create_form', locale: 'es')
      end
    end
  end

  context "Editing a property" do

    background do
      @property = FactoryGirl.create(:property, user: @current_user)
      @property.save
    end

    scenario "Changes some attributes", js: true do
      visit edit_property_path @property
      within edit_property_form do
        fill_in 'property_address', with: 'Laprida 1024'
        fill_in 'property_description', with: 'Exelente salon para fiestas'
        page.select '1', from: 'property_amount_rooms'
        page.select '3', from: 'property_amount_bathrooms'
      end
      property_button_save.click
      page.should have_content I18n.t('flash.property',
                                       message: I18n.t('flash.updated'),
                                       locale: 'es')
    end

    context "When Address is changes to blank" do
      scenario "should be not allow edit a property", js: true do
        visit edit_property_path @property
        within edit_property_form do
          fill_in 'property_address', with: ''
        end
        property_button_save.click
        page.should have_content I18n.t('flash.error_update_form', locale: 'es')
      end
    end
  end
end
