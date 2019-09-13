class Schedule < ApplicationRecord
  belongs_to :cat
  validates :plan_date,  presence: true
  validates :plan_content,  presence: true
  validate :over_day
  
  
  
  
  def over_day
    if self.plan_date.present?
      if self.plan_date < Date.today
         errors.add(:plan_date, "日付がすぎてます") 
      end   
    end    
  end    
end
