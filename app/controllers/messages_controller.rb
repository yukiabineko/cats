class MessagesController < ApplicationController
  before_action :admin_page
  before_action :set_post,only:[:show]
  before_action :set_message,only:[:edit,:update,:destroy,:replay_show,:replay_create]
  before_action :access_block
  
#message 表示登録

  def show
     if !current_user.nil? 
        current_user.info = false
        current_user.save
     end    
    @messages = Message.paginate(page: params[:page],:per_page => 10).where(post_id: @post.id).order('created_at desc')
    if request.post?
      @message = @post.messages.build(message_parameter)  
      if @message.save
        flash[:info] = "投稿完了"
        @post.user.info = true
        @post.user.save
      else
        flash[:info] ="空白で送信しないでください"
      end  
       redirect_to messages_show_url @post
    else
      @message = @post.messages.new
    end  
  end
  
#メッセージの編集モーダル
  def edit
  end  
#メッセージの編集アップデート
  def update
    @message.update_attributes(message_parameter)
    redirect_to messages_show_url  @message.post.id
  end    
#メッセージの削除
  def destroy
    
    @message.destroy
    @message.post.user.info = false
    @message.post.user.save
    redirect_to messages_show_url  @message.post.id
  end  
#返信モーダル
def replay_show
  @reply = @message.replies.new
end

#返信作成
def replay_create
  @reply = @message.replies.new(reply_parameter)
  if @reply.save
    flash[:info] = "返信送信しました"
  else
    flash[:info] = "空欄で送信しないでください"
  end  
  redirect_to messages_show_url @reply.message.post
end
#返信削除
 def delete_reply
    reply = Reply.find(params[:id])
    reply.destroy
   redirect_to messages_show_url reply.message.post
 end    
  
#-------------------------  
private
#メッセージのパラメーター

  def message_parameter
    params.require(:message).permit(:message_content, :user_id)
  end
  
#返信パラメーター
def reply_parameter
  params.require(:reply).permit(:reply_content, :user_id)
end
#投稿のセット

  def set_post
     @post = Post.find(params[:id])
  end   
#メッセージのセット

  def set_message
    @message = Message.find(params[:msg_id])
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
