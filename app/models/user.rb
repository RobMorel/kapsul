class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :capsules, dependent: :destroy
  validates :avatar, presence: true
  validates :name, presence: true, uniqueness: true
end
