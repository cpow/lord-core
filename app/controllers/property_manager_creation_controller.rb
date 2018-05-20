class PropertyManagerCreationController < ApplicationController
  protect_from_forgery except: :create

  def create
    @property_manager = PropertyManager.new(property_manager_params)
    @property_manager.set_placeholder_password
    @property_manager.active = false

    if @property_manager.save
      redirect_to new_property_manager_initializer_path(@property_manager),
                  notice: <<~HEREDOC
                    Thank you for signing up with LivingRoom!
                    Please enter your pasword to finish creating your account!
                  HEREDOC
    end
  end

  private

  def property_manager_params
    params.require(:property_manager).permit(:email, :name)
  end
end
