class MessagesController < ApplicationController
  before_action :set_post
  before_action :access_block
  
#message 表示登録

  def show
    @messages = Message.paginate(page: params[:page]).where(post_id: @post.id).order('message_content desc')
    if request.post?
      @message = @post.messages.build(message_parameter)  
      @message.save
      redirect_to messages_show_url @post
    else
      @message = @post.messages.new
    end  
    
    
  end
  
private
#メッセージのパラメーター

  def message_parameter
    params.require(:message).permit(:message_content, :user_id)
  end
#メッセージのセット

  def set_post
     @post = Post.find(params[:id])
  end   
#非ログインユーザーアクセス制限

  def access_block
    unless logged_in?
      if @post.public == false
        redirect_to posts_path
      end  
    end
  end
end
