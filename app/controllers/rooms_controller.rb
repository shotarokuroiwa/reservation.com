class RoomsController < ApplicationController
  before_action :require_login, except: [ :show ]
  before_action :set_own_room, only: [ :edit, :update, :destroy ]

  # 自分の作成した施設一覧
  def index
    @rooms = current_user.rooms
  end

  def show
    @room = Room.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "施設が見つかりません"
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.new(room_params)

    if @room.save
      if @room.images.blank?
        @room.images.attach(
          io: File.open(Rails.root.join("app", "assets", "images", "default_image.png")),
          filename: "default_image.png",
          content_type: "image/png"
        )
      end

      redirect_to rooms_path, notice: "施設を登録しました"
    else
      render :new
    end
  end

  def edit
  end

def update
  if params[:room][:images].present?
    @room.images.attach(params[:room][:images])
  end

  if @room.update(room_params.except(:images))
    redirect_to room_path(@room), notice: "施設情報を更新しました"
  else
    render :edit
  end
end


  def destroy
    @room.destroy
    redirect_to rooms_path, notice: "施設を削除しました"
  end

  private

  def set_own_room
    @room = current_user.rooms.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to rooms_path, alert: "権限がありません"
  end

  def require_login
    if not current_user
      redirect_to new_session_path, alert: "ログインしてください"
    end
  end

  def room_params
    params.require(:room).permit(:name, :description, :price, :address, images: [])
  end
end
