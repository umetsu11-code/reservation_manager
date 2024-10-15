class RoomsController < ApplicationController
  before_action :set_room, only: %i[show edit update destroy]
  before_action :authenticate_user!  # ユーザーがログインしているかを確認

  # GET /rooms or /rooms.json
  def index
    @rooms = Room.all
    if params[:query].present?
      @rooms = @rooms.where('name LIKE ? OR address LIKE ?', "%#{params[:query]}%", "%#{params[:query]}%")
    end
  
    # 地域での検索条件を追加
    if params[:region].present?
      @rooms = @rooms.where(region: params[:region])
    end
  end
end
  