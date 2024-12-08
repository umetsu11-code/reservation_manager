class Room < ApplicationRecord
    # バリデーション
    validates :name, :description, :price, :address, presence: true
    validates :price, numericality: { greater_than_or_equal_to: 1 }
  
    # 検索用スコープ
    scope :search_by_area, ->(area) { where("address LIKE ?", "%#{area}%") }
    scope :search_by_keyword, ->(keyword) {
      where("name LIKE ? OR description LIKE ?", "%#{keyword}%", "%#{keyword}%")
    }
    #Ransakで住所のみを検索対象とするように設定
    def self.ransackable_attributes(auth_object = nil)
      ["address"]
    end
  end
  
