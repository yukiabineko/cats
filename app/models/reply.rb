class Reply < ApplicationRecord
  belongs_to :message
  validates :reply_content,presence:true
end
