class RoomsController < ApplicationController
  before_action :require_login
  before_action :set_room, only: [ :show, :edit, :update, :destroy ]

  # 自分の作成した施設一覧
  def index
    @rooms = current_user.rooms
  end

  def show
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.new(room_params)
    if @room.save
      redirect_to rooms_path, notice: "施設を登録しました"
    else
      flash.now[:alert] = "施設の登録に失敗しました"
      render :new
    end
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to room_path(@room), notice: "施設情報を更新しました"
    else
      flash.now[:alert] = "施設情報の更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @room.destroy
    redirect_to rooms_path, notice: "施設を削除しました"
  end

  private

  def set_room
    @room = current_user.rooms.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to rooms_path, alert: "施設が見つかりません"
  end

  def require_login
    if not current_user
      redirect_to new_session_path, alert: "ログインしてください"
    end
  end

  def room_params
    params.require(:room).permit(:name, :description, :price, :address, :image)
  end
end
