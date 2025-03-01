class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to root_path, success: t("defaults.flash_message.user_sessions.create"), status: :see_other
    else
      flash.now[:error] = t("defaults.flash_message.user_sessions.not_create")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, success: t("defaults.flash_message.user_sessions.destroy"), status: :see_other
  end
end
