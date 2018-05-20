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
      redirect_to new_property_manager_session_path,
        notice: <<~HEREDOC
          Thank you for creating your account! Now log in with the password you
          just added!
        HEREDOC
    else
      render :new
    end
  end

  private

  def property_manager_params
    params.require(:property_manager).permit(:password, :password_confirmation)
  end
end
