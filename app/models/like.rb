class Like < ApplicationRecord
  belongs_to :capsule

  validates :like, presence: true, inclusion: { in: [true, false] }
end
