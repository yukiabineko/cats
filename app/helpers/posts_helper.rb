module PostsHelper

#投稿された名前配列格納    
    def post_names
        array = []
        
        @data_post.each do |post|
          array << post.user.name
        end
      return array.uniq 
    end
    
end
