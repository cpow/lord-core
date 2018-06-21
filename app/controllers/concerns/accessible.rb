module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected

  def check_user
    if current_property_manager
      flash.clear
      # if you have rails_admin. You can redirect anywhere really
      redirect_to(authenticated_property_manager_root_path) && return
    elsif current_user
      flash.clear
      redirect_to(authenticated_user_root_path) && return
    end
  end
end
