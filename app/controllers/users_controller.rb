class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_login, only: [:show, :edit, :update]
  
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

  def edit
  end

  def update
    if @user.update(user_params)
      if user_params[:password].present? || user_params[:email].present?
        reset_session
        redirect_to new_session_path, notice: "パスワードを変更しました。再度ログインしてください"
      else
        redirect_to account_path, notice: "アカウント情報を更新しました"
      end
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :icon_image, :introduction)
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
