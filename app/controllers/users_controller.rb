class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :edit_account, :edit_profile, :update ]
  before_action :require_login, only: [ :show, :edit_account, :edit_profile, :update ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path, notice: "アカウントを登録しました"
    else
      flash.now[:alert] = "登録に失敗しました"
      render :new
    end
  end

  def show
  end

  def edit_account
  end

  def edit_profile
  end

  def update
    if account_update? &&
      params.dig(:user, :email) == @user.email &&
      params[:user][:password].blank?

      render :edit_account
      return
    end

    if @user.update(user_params)
      if account_update?
        reset_session
        redirect_to new_session_path,
          notice: "アカウント情報を変更しました。再度ログインしてください"
      else
        redirect_to user_path(@user), notice: "プロフィールを更新しました"
      end
    else
      render_edit_form
    end
  end

  private

  def account_update?
    params[:edit_type] == "account"
  end

  def user_params
    if account_update?
      params.require(:user).permit(
        :email,
        :password,
        :password_confirmation,
        :current_password
      )
    else
      params.require(:user).permit(
        :name,
        :icon,
        :introduction
      )
    end
  end

  def render_edit_form
    if account_update?
      render :edit_account, status: :unprocessable_entity
    else
      render :edit_profile, status: :unprocessable_entity
    end
  end

  def set_user
    @user = current_user
  end

  def require_login
    if not current_user
      redirect_to new_session_path, alert: "ログインしてください"
    end
  end
end
