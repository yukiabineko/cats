class Schedule < ApplicationRecord
  belongs_to :cat
  validates :plan_date,  presence: true
  validates :plan_content,  presence: true
end
