class ReservationsController < ApplicationController
  before_action :require_login
  before_action :set_room, only: [ :new, :create ]
  before_action :build_reservation, only: [ :create ]

  def new
      @reservation = @room.reservations.new
  end

  def create
    @reservation.user = current_user
    if @reservation.check_in.present? && @reservation.check_out.present? && @reservation.people.present?
      @reservation.total_price = calculate_total(@reservation)
    end

    if @reservation.save
      redirect_to reservations_path, notice: "予約が確定しました"
    else
      flash.now[:alert] = "予約に失敗しました"
      render :new
    end
  end

  def index
    @reservations = current_user.reservations.includes(:room)
  end

  def show
    @reservation = current_user.reservations.includes(:room).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to reservations_path, alert: "予約が見つかりません"
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "施設が見つかりません"
  end

  def build_reservation
    @reservation = @room.reservations.new(reservation_params)
  end

  def require_login
    if not current_user
      redirect_to new_session_path, notice: "ログインしてください"
    end
  end

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :people)
  end

  def calculate_total(reservation)
    days = (reservation.check_out - reservation.check_in).to_i
    days * reservation.people * reservation.room.price
  end
end
