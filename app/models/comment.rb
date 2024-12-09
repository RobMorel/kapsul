class Comment < ApplicationRecord
  belongs_to :capsule

  validates :comment, presence: true, length: { maximum: 300 }
end
