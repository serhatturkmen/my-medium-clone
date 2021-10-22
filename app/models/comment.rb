class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  scope :accepted, -> { where(status: 1) }

  scope :user_comments, ->(user_id) { where(user_id: user_id).where(status: 0)}
end
