module PostsHelper
#投稿された日付け配列格納    
    def post_names
        array = []
        @data_post.each do |date|
          array << date.user.name
        end
      return array.uniq 
    end        
     def name_list
        array = []
        posts = Post.all
        posts.each do |post|
          array << post.user.name        
        end   
        return array.uniq
     end
end
