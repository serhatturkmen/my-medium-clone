class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true

  has_many_attached :files

  scope :availables, -> { where(visible: true).order(created_at: :desc) }
end
