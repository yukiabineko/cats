module MessagesHelper
    def replay_count(message)
        return message.replies.all.count
    end
    
    def replies(message)
        return message.replies.all
    end
    
   
end
