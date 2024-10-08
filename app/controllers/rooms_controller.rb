class RoomsController < ApplicationController
  before_action :set_room, only: %i[show edit update destroy]
  before_action :authenticate_user!  # ユーザーがログインしているかを確認

  # GET /rooms or /rooms.json
  def index
    if params[:query].present?
      @rooms = Room.where('name LIKE ? OR address LIKE ?', "%#{params[:query]}%", "%#{params[:query]}%")
    else
      @rooms = Room.all
    end
 # 地域で検索ができるように設定
    if params[:region].present?
      @rooms = @rooms.where(region: params[:region])
    end

  end

  # GET /rooms/1 or /rooms/1.json
  def show
    @reservation = Reservation.new
  end

  # GET /rooms/new
  def new
    #@room = Room.new
    @reservation = Reservation.new # ここで予約オブジェクトも新規作成
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms or /rooms.json
  def create
    @room = Room.new(room_params)
    @room = current_user.rooms.new(room_params)  # 現在ログインしているユーザーに紐付ける


    respond_to do |format|
      if @room.save
        format.html { redirect_to room_url(@room), notice: "施設の登録が完了しました。" }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to room_url(@room), notice: "Room was successfully updated." }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: "Room was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_room
    @room = Room.find(params[:id])
    @rooms = current_user.rooms
  end

  # Only allow a list of trusted parameters through.
  def room_params
    params.require(:room).permit(:name, :description, :price, :address, :image, :user_id)
  end
end