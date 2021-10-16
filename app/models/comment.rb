class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  scope :accepteds, -> { where(accept: true) }
end
