class PlanComment < ApplicationRecord
  belongs_to :user
  belongs_to :plan
end
