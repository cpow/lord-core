class Companies::PropertyManagersController < ApplicationController
  before_action :authenticate_property_manager!
  before_action :can_manage_company!
  before_action :company

  def show
    @property_manager = company.property_managers.find(params[:id])
  end

  def new
    @property_manager = company.property_managers.new
  end

  def create
    # check if email already exists and PM is not active
    @property_manager = company.property_managers.new(property_manager_options)
    @property_manager.set_placeholder_password unless @property_manager.active
    @property_manager.invited_by_id = current_property_manager.id
    @property_manager.invite_date = DateTime.now

    if @property_manager.save
      PropertyManagerInviterMailer.invite(
        @property_manager, @property_manager.company
      ).deliver_later
      redirect_to authenticated_property_manager_root_path, notice: <<~HEREDOC
        Property manager has successfully been invited! An invite email has been
        sent. To check their status, head over to your company page.
      HEREDOC
    else
    end
  end

  private

  def property_manager_options
    property_manager_params.merge(active: false)
  end

  def company
    @company ||= Company.find(params[:company_id])
  end

  def property_manager_params
    params.require(:property_manager).permit(:name, :admin, :email)
  end
end
