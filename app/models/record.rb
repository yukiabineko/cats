class Record < ApplicationRecord
    belongs_to :cat
    validate :minus_check
    
    def minus_check
      if self.result_weight <= 0
        errors.add(:result_weigh, "0またはマイナスは入力できません！")
      end    
    end    
end
