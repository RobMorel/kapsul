class Capsule < ApplicationRecord
  belongs_to :user

  has_many :comments
  has_many :likes

  validates :title, presence: true
  validates :teasing, presence: true, length: { maximum: 200 }
  validates :category, presence: true
  validates :address, presence: true
end
