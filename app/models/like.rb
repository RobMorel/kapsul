class Like < ApplicationRecord
  belongs_to :capsule
  belongs_to :user

  validates :capsule_id, uniqueness: { scope: :user_id }
end
