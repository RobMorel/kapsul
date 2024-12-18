class Comment < ApplicationRecord
  belongs_to :capsule
  belongs_to :user

  validates :comment, presence: true, length: { maximum: 300 }
end
