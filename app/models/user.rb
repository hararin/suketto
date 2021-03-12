class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :requests
  has_many :participants
  has_many :purchases
  has_many :reports

  validates :name, presence: true
  validates :age, presence: true
  validates :sex, presence: true
  validates :ticket, presence: true

  attachment :image

  enum sex: { 女性: 0, 男性: 1}

  include Discard::Model

end
