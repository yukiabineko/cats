class PostsController < ApplicationController
  

#投稿一覧  
  def index
  end

#新規投稿
  def new
    user = User.find(params[:user_id])
    @post = user.posts.new
    @array = [["相談/質問","相談/質問"],["日記","日記"],["マイキャット","マイキャット"],["雑談","雑談"],["イベント","イベント"],["その他","その他"]]
  end

  def edit
  end

  def show
  end
end
