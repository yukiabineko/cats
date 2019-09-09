class Cat < ApplicationRecord
  belongs_to :user
  validates :cat_name,  presence: true, length: { maximum: 50 }    
end
