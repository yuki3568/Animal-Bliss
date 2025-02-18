class ApplicationController < ActionController::Base
  # allow_browser versions: :modern
  before_action :require_login
  add_flash_types :success, :error

  private

  def not_authenticated
    redirect_to login_path
  end
end
