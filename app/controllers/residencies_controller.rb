class ResidenciesController < ApplicationController
  before_action :authenticate_property_manager!
  before_action :verify_units_available

  def new
    @residency = current_property.residencies.new
  end

  def create
    @residency = current_property.residencies.new(residency_params)

    creator = Residency::CreateFromProperty
              .new(property: current_property, residency: @residency)

    return_value = creator.save

    case return_value
    when Residency::ERROR
      flash[:danger] = 'There were errors'
      return render :new
    when Residency::EXISTS
      flash[:info] = 'this resident already exists for your property.'
      return render :new
    else
      flash[:success] = 'New resident has been added! They will be invited by email.'
      return redirect_to current_property
    end
  end

  private

  def current_property
    @property ||= Property.find(params[:property_id])
  end

  def residency_params
    params.require(:residency).permit(:user_email, :property_id, :unit_id, :company_id)
  end

  def verify_units_available
    unless current_property.units.count > 0
      flash[:notice] = "You must create a unit for this property first! :)"
      redirect_to properties_path(current_property_manager.company)
    end
  end
end
