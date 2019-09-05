class PostsController < ApplicationController
  before_action :set_user,only:[:new,:create]
  before_action :set_array,only:[:new,:create,:post_edit]

#投稿一覧  
  def index
    if logged_in?
      @posts = Post.paginate(page: params[:paginate],:per_page => 10).order('created_at desc')
    else
      @posts = Post.paginate(page: params[:paginate],:per_page => 10).where.not(public: false).order('created_at desc')  #公開投稿のみ
    end  
    
    
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
  
#=投稿編集モーダル

  def post_edit
    @post = Post.find(params[:id])
    
  end
  
#=投稿編集モーダルアップデート  

  def post_update
    @post =  Post.find(params[:id])
    if @post.update_attributes(post_parameter)
      flash[:success] = "編集しました"
    else
       flash[:success] = "編集失敗内容を確認してください"
    end    
    redirect_to posts_url
  end
#投稿削除
def destroy
   
   @post = Post.find(params[:id])
   @post.destroy
   flash[:success] = "削除しました"
   redirect_to posts_url
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
    @data = [["質問","質問"],["相談","相談"],["日記","日記"],["雑談","雑談"],["生活","生活"],["その他","その他"]]  
  end
end
