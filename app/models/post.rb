class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :title, presence: true
  validates :content, presence: true

  scope :availables, -> { where(visible: true).order(created_at: :desc) }
end
