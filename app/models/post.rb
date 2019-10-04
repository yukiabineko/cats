class Post < ApplicationRecord
  belongs_to :user
  has_many :messages,dependent: :destroy
  validates :post_title,  presence: true,length: { maximum: 12 } 
  validates :post_content,  presence: true
end
