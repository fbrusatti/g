class LandingController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json { render json: LandingPageDatatable.new(view_context) }
    end
  end
end
