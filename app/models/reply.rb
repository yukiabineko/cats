class Reply < ApplicationRecord
  belongs_to :message
  belongs_to :user
  validates :reply_content,presence:true
end
