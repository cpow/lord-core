class UnitsController < ApplicationController
  before_action :authenticate_property_manager!
  before_action :set_unit, only: [:show, :edit, :update, :destroy]
  before_action :set_property
  before_action :set_company

  def index
    @units = current_property.units
  end

  def show
  end

  def new
    @unit = current_property.units.new
  end

  def edit
  end

  def create
    @unit = current_property.units.new(unit_params)

    respond_to do |format|
      if @unit.save
        format.html { redirect_to current_property, notice: 'Unit was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @unit.update(unit_params)
        format.html { redirect_to [current_property, @unit], notice: 'Unit was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @unit.destroy
    respond_to do |format|
      format.html { redirect_to units_url, notice: 'Unit was successfully destroyed.' }
    end
  end

  private

  def set_unit
    @unit = current_property.units.find(params[:id])
  end

  def unit_params
    params.require(:unit).permit(:property_id, :description, :name)
  end
end
