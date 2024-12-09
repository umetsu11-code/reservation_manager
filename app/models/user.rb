class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	# Deviseのモジュールやその他のロジック
  # ユーザー情報のバリデーションを追加
  validates :name, presence: true, length: { maximum: 50 }
  validates :introduction, length: { maximum: 300 }
  
  has_many :reservations, dependent: :destroy
  has_one_attached :icon # Active Storageを使う場合の追記
  end
