class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def handle_error(message = "Sorry, something failed.", view = 'new')
    flash.now[:danger] = message
    render view
  end

  private

  def current_company
    current_property_manager.company
  end

  def can_manage_company!
    current_property_manager&.is_company_admin?
  end

  def can_create_company
    if current_property_manager.has_company?
      flash[:error] = 'You already have a company, you cannot create another'
      redirect_to page_path('property_manager_home')
    end
  end
end
