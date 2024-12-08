class ReservationsController < ApplicationController
    before_action :set_reservation, only: [:show]
    before_action :set_room, only: [:new, :create]
    before_action :authenticate_user!
    
    # 予約一覧
    def index
      @reservations = current_user.reservations.includes(:room)
    end
  
    # 予約確認ページ
    def show
    end
  
    # 新規作成フォーム
    def new
      @reservation = Reservation.new
      @room = Room.find(params[:room_id])
    end
  
    # 作成処理
    def create
      @reservation = current_user.reservations.new(reservation_params)
      @reservation.room = Room.find(params[:room_id])
  
      if @reservation.save
        redirect_to @reservation, notice: "予約が確定しました。"
      else
        render :new
      end
    end
  
    private
  
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end
  
    def reservation_params
      params.require(:reservation).permit(:check_in_date, :check_out_date, :number_of_guests)
    end
  end
  