class PropertyManagersController < ApplicationController
  before_action :authenticate_property_manager!

  def show
    @property_manager = current_property_manager
  end

  def edit
    @property_manager = current_property_manager
  end

  def update
    @property_manager = current_property_manager
    if @property_manager.update(property_manager_params)
      redirect_to @property_manager, notice: 'Success!'
    else
      render :edit
    end
  end

  private

  def property_manager_params
    params.require(:property_manager).permit(:email, :name)
  end
end
