module MessagesHelper
    def replay_count(message)
        return message.replies.all.count
    end        
end
