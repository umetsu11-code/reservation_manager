class Reservation < ApplicationRecord
  belongs_to :room
    # バリデーション
    validates :check_in_date, :check_out_date, :number_of_guests, presence: true
    validates :check_in_date, comparison: { greater_than_or_equal_to: Date.today, message: "は本日以降の日付を選択してください" }
    validates :check_out_date, comparison: { greater_than: :check_in_date, message: "はチェックイン日より後の日付を選択してください" }
    validates :number_of_guests, numericality: { greater_than_or_equal_to: 1, message: "は1人以上である必要があります" }
  
    # 宿泊日数を計算
    def total_days
      (check_out_date - check_in_date).to_i
    end
  
    # 合計料金を計算
    def total_price
      total_days * number_of_guests * room.price
    end
end
