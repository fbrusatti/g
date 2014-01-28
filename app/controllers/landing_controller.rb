class LandingController < ApplicationController

  before_filter :authenticate_user!

  def index
    respond_to do |format|
      format.html
      format.json { render json: LandingPageDatatable.new(view_context) }
    end
  end
end
