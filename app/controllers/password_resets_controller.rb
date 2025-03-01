class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  def new; end

  def create
    @user = User.find_by_email(params[:email])
    # オプショナルチェイニングを使うことで、nilの可能性があるオブジェクトに対してメソッドを呼び出す際のエラーを防ぐ
    if @user&.deliver_reset_password_instructions!
      redirect_to root_path, success: t(".success")
    else
      flash.now[:error] = t(".error")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    not_authenticated if @user.blank?
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    return not_authenticated if @user.blank?

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password(params[:user][:password])
      redirect_to login_path, success: t(".success")
    else
      flash.now[:error] = t(".error")
      render :edit, status: :unprocessable_entity
    end
  end
end
