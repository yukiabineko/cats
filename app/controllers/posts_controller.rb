class PostsController < ApplicationController
  before_action :admin_page  
  before_action :set_user,only:[:new,:create]
  before_action :set_array,only:[:index,:new,:create,:post_edit]

#投稿一覧  
  def index
    @datas =  [["すべて","すべて"],["質問","質問"],["相談","相談"],["日記","日記"],["雑談","雑談"],["生活","生活"],["その他","その他"]]   
    if logged_in?      #ログインしていてのですべてのデータ
      if params[:category]
         @posts = Post.where(category: params[:category]).order('created_at desc')
         @posts2 = []
         if params[:category] == "すべて"
           @posts2 = Post.paginate(page: params[:page],:per_page => 5).order('created_at desc')
           @posts = []   #検索より片方をからに
         end 
#パラメータ日付け時         
      elsif params[:date]
        if params[:date].blank?
           flash[:info] = "検索日が無効です"
           redirect_to posts_url
        else
            @posts = Post.where("created_at >= ? AND created_at < ?", Date.parse(params[:date]), Date.parse(params[:date]) + 1).order('created_at desc')
            @posts2 = nil  #検索より片方をからに
            if @posts.count ==0
               flash[:info] = "その日付に投稿はありません"
               
            end        
        end    
          
#パラメータ投稿者時
      elsif params[:name]
        user= User.find_by(name: params[:name])
        @posts = Post.where('user_id=?',user.id).order('created_at desc') 
        @posts2 = []  #検索より片方をからに
#default
      else
         @posts2 = Post.paginate(page: params[:page],:per_page => 5).order('created_at desc')
         @posts = []   #検索より片方をからに
      end  
#-----------------------      
#ログインされてないので　公開許可ののみ      
    else
       if params[:category]
           @posts = Post.where(category: params[:category],public:true).order('created_at desc')
           @posts2 = []
         if params[:category] == "すべて"
           @posts2 = Post.paginate(page: params[:page],:per_page => 5).where(public: true).order('created_at desc')
           @posts =[]
         end 
       elsif params[:date]  #日検索
          if params[:date].blank?
              flash[:info] = "検索日が無効です"
              redirect_to posts_url
          else
             @posts = Post.where("created_at >= ? AND created_at < ?", Date.parse(params[:date]), Date.parse(params[:date]) + 1)
             .where(public:true).order('created_at desc')
              @posts2 = []
             if @posts.count ==0
               flash[:info] = "その日付に投稿はありません"
              
             end        
          end          
       #パラメータ投稿者時
       elsif params[:name]
         user= User.find_by(name: params[:name])
         
         @posts = Post.where(user_id: user.id,public: true).order('created_at desc')    
         @posts2 = []
       else
         @posts2 = Post.paginate(page: params[:page],:per_page => 5).where.not(public: false).order('created_at desc')  #公開投稿のみ default
         @posts = []
       end  
    end  
#ピックアップ用
      @data_post = Post.all
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
    @data = [["質問","質問"],["相談","相談"],["日記","日記"],["雑談","雑談"],["生活","生活"],["その他","その他"]]  
  end

end
