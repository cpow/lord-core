class InvitationAcceptancesController < ApplicationController
  before_action :set_user

  def new
  end

  def create
    @user.update_attributes(user_params)
    @user.activated = true
    Event.create!(eventable: @user,
                 event_type: Event::ACCEPTED_INVITE,
                 createable: @user)

    if @user.save
      flash[:success] = 'Thank you for accepting the invitation! Now Log In'
      redirect_to new_user_session_path
    else
      render :new
    end
  end

  private

  def set_user
    @user = User.inactive.find_by(invite_token: params[:user_id])
    if @user.nil?
      flash[:danger] = 'no user with that token can accept invite'
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
