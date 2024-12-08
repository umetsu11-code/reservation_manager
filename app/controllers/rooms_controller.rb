class RoomsController < ApplicationController
    before_action :set_room, only: [:show]
  
    # 施設一覧 Ransackでの検索処理
    def index
      @q = Room.ransack(params[:q])
      @rooms = @q.result(distinct: true)
      
    # エリア検索処理
    if params[:area].present?
      @rooms = @rooms.where(address: params[:area])
    end

      @total_rooms = @rooms.count
    end
  
    # 施設詳細
    def show
    end
  
    # 新規作成フォーム
    def new
      @room = Room.new
    end
  
    # 作成処理
    def create
      @room = Room.new(room_params)
      if @room.save
        redirect_to @room, notice: "施設が作成されました。"
      else
        render :new
      end
    end
  
    private
  
    def set_room
      @room = Room.find(params[:id])
    end
  
    def room_params
      params.require(:room).permit(:name, :description, :price, :address, :image_url)
    end
  end
  