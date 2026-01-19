class SessionsController < ApplicationController
  # ログイン画面
  def new
    if current_user
      redirect_to root_path
    end
  end

  # ログイン処理
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "ログインしました"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが違います"
      render :new
    end
  end

  # ログアウト
  def destroy
    reset_session
    respond_to do |format|
      format.html { redirect_to root_path, notice: "ログアウトしました" }
    end
  end
end
