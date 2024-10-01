class FacilitiesController < ApplicationController
  def index
    @facilities = Facility.all
  end

  def show
    @facility = Facility.find(params[:id])
  end

  def new
    @facility = Facility.new
  end

  def create
    @facility = Facility.new(facility_params)
    if @facility.save
      redirect_to @facility
    else
      render 'new'
    end
  end

  private

  def facility_params
    params.require(:facility).permit(:name, :address, :description)
  end
end
