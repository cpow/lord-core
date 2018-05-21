class PropertyManagers::InitializerController < ApplicationController
  def new
    @property_manager = PropertyManager.find(params[:property_manager_id])
    unless !@property_manager.active
      redirect_to new_property_manager_session_path,
        notice: 'This account is already active. Please sign in'
    end
  end

  def create
    @property_manager = PropertyManager.find(params[:property_manager_id])
    if @property_manager.update(property_manager_params.merge(active: true))
      PropertyManagers::CreateService.new(
        property_manager: @property_manager
      ).handle_callbacks!
      sign_in(@property_manager)
      redirect_to authenticated_property_manager_root_path(@property_manager)
    else
      render :new
    end
  end

  private

  def property_manager_params
    params.require(:property_manager).permit(:password, :password_confirmation)
  end
end
