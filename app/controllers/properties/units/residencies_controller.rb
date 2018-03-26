class Properties::Units::ResidenciesController < ApplicationController
  before_action :authenticate_property_manager!
  before_action :verify_units_available
  before_action :set_property
  before_action :set_company
  before_action :set_unit

  def new
    @residency = current_property.residencies.new
    @residency.unit = @unit
    @property = current_property
    @company = current_property.company
  end

  def index
    @residencies = current_property.residencies
  end

  def show
    @residency = Residency.find(params[:id])
  end

  def send_another_invite
    @residency = Residency.find(params[:id])
    InviteUserToPropertyMailer.invite(@residency).deliver_later

    flash[:success] = 'Another invite email has been sent to resident!'
    redirect_to [@residency.property, @residency.unit, @residency]
  end

  def create
    @residency = current_property.residencies.new(residency_params)

    creator = Residency::CreateFromProperty
              .new(property: current_property,
                   residency: @residency,
                   manager: current_property_manager
                  )

    return_value = creator.save

    case return_value
    when Residency::ERROR
      flash[:danger] = 'There was an error with this submission. Please make sure you filled out the form correctly'
      return render :new
    when Residency::EXISTS
      flash[:info] = 'this resident already exists for your property.'
      return render :new
    else
      flash[:success] = 'New resident has been added! They will be invited by email.'
      return redirect_to [@residency.property, @residency.unit]
    end
  end

  private

  def current_property
    @property ||= Property.find(params[:property_id])
  end

  def set_unit
    @unit = params[:unit_id] ? Unit.find(params[:unit_id]) : nil
  end

  def residency_params
    params.require(:residency).permit(:user_email, :property_id, :unit_id, :company_id)
  end

  def verify_units_available
    unless current_property.units.count > 0
      flash[:notice] = "You must create a unit for this property first! :)"
      redirect_to property_unit_path(@unit)
    end
  end
end
