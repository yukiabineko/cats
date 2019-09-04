class PostsController < ApplicationController
  before_action :set_user,only:[:new,:create]
  before_action :set_array,only:[:new,:create]

#投稿一覧  
  def index
    @posts = Post.paginate(page: params[:paginate],:per_page => 10)
  end

#新規投稿
  def new
    @post = @user.posts.new
  end
  
#登録
  def create
    @post = @user.posts.new(post_parameter)
   
    if @post.save
      redirect_to posts_url  
    else
      render :new
    end  
  end

  def edit
  end

  def show
  end
  
private

#パラメーター
   def post_parameter
     params.require(:post).permit(:post_title, :post_content, :category, :public, :user_id)
   end
#ユーザーセット

  def set_user
    @user = User.find(params[:user_id])   
  end
#配列セット

  def set_array
    @data = [["質問","質問"],["相談","相談"],["日記","日記"],["雑談","雑談"],["キャットライフ","キャットライフ"],["その他","その他"]]  
  end
end
