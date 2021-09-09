class Hangout < ApplicationRecord
  has_many :user_hangout_funs
  has_many :user_hangout_results
end
