class Plan < ApplicationRecord
  has_many :participations
  has_many :plan_comments
  belongs_to :user
end
