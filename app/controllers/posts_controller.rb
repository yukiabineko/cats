class PostsController < ApplicationController
  before_action :set_user,only:[:new,:create]
  before_action :set_array,only:[:index,:new,:create,:post_edit]

#投稿一覧  
  def index
     
    if logged_in?      #ログインしていてのですべてのデータ
      if params[:category]
         @posts = Post.paginate(page: params[:paginate],:per_page => 10).where(category: params[:category]).order('created_at desc')
         if params[:category] == "すべて"
           @posts = Post.paginate(page: params[:paginate],:per_page => 10).order('created_at desc')
         end 
#パラメータ日付け時         
      elsif params[:date]
          @posts = Post.paginate(page: params[:page]).where('created_at like?','%'+params[:date]+'%').order('created_at desc') 
#パラメータ投稿者時
      elsif params[:name]
        user= User.find_by(name: params[:name])
        @posts = Post.paginate(page: params[:page]).where('user_id=?',user.id).order('created_at desc') 
#default
      else
         @posts = Post.paginate(page: params[:paginate],:per_page => 10).order('created_at desc')
      end  
#-----------------------      
#ログインされてないので　公開許可ののみ      
    else
       if params[:category]
           @posts = Post.paginate(page: params[:paginate],:per_page => 10).where(category: params[:category],public:true).order('created_at desc')
         if params[:category] == "すべて"
           @posts = Post.paginate(page: params[:paginate],:per_page => 10).where(public: true).order('created_at desc')
         end 
       elsif params[:date]
          @posts = Post.paginate(page: params[:page]).where('created_at like?','%'+params[:date]+'%',public: true).order('created_at desc')
       #パラメータ投稿者時
       elsif params[:name]
         user= User.find_by(name: params[:name])
         @posts = Post.paginate(page: params[:page]).where('user_id=?',user.id,public: true).order('created_at desc')    
       else
         @posts = Post.paginate(page: params[:paginate],:per_page => 10).where.not(public: false).order('created_at desc')  #公開投稿のみ default
       end  
    end  
#ピックアップ用
      @data_post = Post.paginate(page: params[:page],:per_page => 10).order("created_at desc")
  end
#-------------------------------------------------------ここまでindex--------------------------------------

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
    @data = [["すべて","すべて"],["質問","質問"],["相談","相談"],["日記","日記"],["雑談","雑談"],["生活","生活"],["その他","その他"]]  
  end

end
