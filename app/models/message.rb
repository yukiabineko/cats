class Message < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :replies,dependent: :destroy
  validates :message_content,presence:true
end
