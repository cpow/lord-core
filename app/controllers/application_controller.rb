class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def handle_error(message = "Sorry, something failed.", view = 'new')
    flash.now[:danger] = message
    render view
  end

  def current_company
    current_property_manager.company
  end

  def set_company
    @company ||= current_company
  end

  def current_property
    @property ||= Property.find(params[:property_id])
  end

  def set_unit
    @unit ||= Unit.find(params[:unit_id])
  end

  def set_lease_payment
    @lease_payment ||= LeasePayment.find(params[:lease_payment_id])
  end

  def set_property
    @property = current_property
  end

  def filter_params(keys, initial_obj)
    #this will build out the search params from the client
    keys.inject(initial_obj) do |obj, param_key|
      if params[param_key].present?
        obj.merge!(Hash[param_key, params[param_key]])
      end
      obj
    end
  end

  private

  def can_manage_company!
    current_property_manager&.is_company_admin?
  end

  def can_create_company
    if current_property_manager.has_company?
      flash[:error] = 'You already have a company, you cannot create another'
      redirect_to authenticated_user_root_path
    end
  end
end
