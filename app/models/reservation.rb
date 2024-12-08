class Reservation < ApplicationRecord
  # 一つの宿泊施設が一人に紐づくように設定
  belongs_to :user
  belongs_to :room
  
  # バリデーション
  validates :check_in_date, :check_out_date, :guest_count, presence: true
  validate :check_in_date_must_be_in_the_future
  validate :check_out_date_must_be_after_check_in_date
  validates :guest_count, numericality: { greater_than_or_equal_to: 1 }

  private

  # チェックイン日が今日以降であることを確認
  def check_in_date_must_be_in_the_future
    if check_in_date.present? && check_in_date < Date.today
      errors.add(:check_in_date, "は今日以降の日付を指定してください")
    end
  end

  # チェックアウト日がチェックイン日より後であることを確認
  def check_out_date_must_be_after_check_in_date
    if check_out_date.present? && check_in_date.present? && check_out_date <= check_in_date
      errors.add(:check_out_date, "はチェックイン日より後の日付を指定してください")
    end
  end

    # 宿泊日数を計算
    def total_days
      (check_out_date - check_in_date).to_i
    end
  
    # 合計料金を計算
    def total_price
      total_days * number_of_guests * room.price
    end

end
