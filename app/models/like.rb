class Like < ApplicationRecord
  belongs_to :capsule
  belongs_to :user

  validates :like, presence: true, inclusion: { in: [true, false] }
end
