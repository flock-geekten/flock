class Post < ApplicationRecord
  has_many :post_tags
  has_many :tags, through: :post_tags
  has_many :comments
  has_one :summary, dependent: :destroy
  belongs_to :user
end
