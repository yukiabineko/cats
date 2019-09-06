class MessagesController < ApplicationController
  before_action :set_post
  before_action :access_block
  
  
  def show
   
  end
  
private
  def set_post
     @post = Post.find(params[:id])
  end   
  
  def access_block
    unless logged_in?
      if @post.public == false
        redirect_to posts_path
      end  
    end
  end
end
