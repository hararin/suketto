class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :requests, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :purchases

  validates :name, presence: true
  validates :age, presence: true
  validates :sex, presence: true

  attachment :image

  enum sex: { 女性: 0, 男性: 1}
end
