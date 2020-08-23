class Post < ApplicationRecord

  belongs_to :user

  validates :title, presence: true, length: { maximum: 500 }
  validates :url, presence: true, length: { maximum: 2000 * 1000 }
end
