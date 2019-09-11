class UsersController < ApplicationController
  before_action :set_user,only:[:show,:edit, :destroy, :show_image,:correct_user, :cat_new, ]
  before_action :set_cat,only:[:cat_modal,:cat_delete, :cat_edit, :cat_update]
  before_action :logged_in_user, only: [:index,:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update,:cat_new]
  before_action :admin_user,only: :destroy
  
  

  #ユーザー全表示ページネーション機能持ち
  def index 
    @users = User.paginate(page: params[:page],:per_page => 2)
  end

  def new                   #新規登ページ
    @user = User.new
    
  end
  
  def create                #新規登録
    @user = User.new(user_parameter)
    
    if @user.save
       log_in @user # 保存成功後、ログインします。
      flash[:success] = '登録しました。'
       redirect_to @user
    else
      render :new
    end  
  end

  def edit
  end
#猫新規登録ページ

 def cat_new
   @cat = @user.cats.new
 end
#猫登録

def cat_create
   @user = User.find(params[:user_id])
   @cat = @user.cats.new(cat_parameter)
   
   if @cat.save
      redirect_to user_url @user
   else
     render :cat_new
   end   
end 
#猫編集モーダル
  def cat_edit
  end

#猫詳細モーダル

def cat_modal
end  
#猫データアップデート
def cat_update
  @cat = Cat.find(params[:id])
  if @cat.update_attributes(cat_parameter)
     flash[:success] = "編集成功"
  else
    flash[:danger] = "編集失敗"
  end  
  redirect_to user_url @cat.user
end
#猫データ削除

def cat_delete
  @cat.destroy
  redirect_to user_url @cat.user
end

#猫計画モーダル
def cat_plan
  
end

#各オーナーさん個別ページ

  def show
    @cats = @user.cats.all
  end
  
#update  
  def update     
    @user = User.find(params[:id])
    if @user.update_attributes(user_parameter)
      flash[:success] = "情報更新しました。"
      redirect_to @user
    else
      render :edit      
    end
  end
#ユーザー削除
  def destroy
     @user.destroy
     flash[:success] = "オーナー情報#{@user.name}を削除しました。"
     redirect_to users_url
  end
 #画像バイナリー表示オーナー 
  def show_image  
    send_data @user.image
  end
 #画像バイナリー表示猫
  def cat_show_image  
     @cat = Cat.find(params[:id])
    send_data @cat.cat_image
  end  
  
#-----------------------------------------------------------------------------------  
private
   #個別ユーザー呼び出し
  def set_user                                                               
    @user = User.find(params[:id] )
  end
#個別猫呼び出し
  def set_cat
     @cat = Cat.find(params[:id])
  end
  
  def user_parameter     #ユーザーのpost patchパラメーター    rmasicで処理
     if params[:user][:image]
        params[:user][:image] = params[:user][:image].read
        image = params[:user][:image]
        rmagick_image = Magick::Image.from_blob(image).first
        rmagick_image = image2.resize(0.6)
        rmagick_image.auto_orient!
        rmagick_image.strip!
        rmagick_image.write('public/make.jpg')
        params[:user][:image] = File.open('public/make.jpg').read
     elsif params[:user][:image].nil?
         params[:user][:image] = File.open('public/user.png').read 
     end
    params.require(:user).permit(:image, :name, :email, :password, :password_confirmation)
  end
  
 #猫パラメーター
  def cat_parameter
    if params[:cat][:cat_image]
        params[:cat][:cat_image] = params[:cat][:cat_image].read
        image = params[:cat][:cat_image]
        image2 = Magick::Image.from_blob(image).first
        rmagick_image = image2.resize(0.6)
        rmagick_image.auto_orient!
        rmagick_image.strip!
        rmagick_image.write('public/make2.jpg')
        params[:cat][:cat_image] = File.open('public/make2.jpg').read
    elsif params[:cat][:cat_image].nil?
         params[:cat][:cat_image] = File.open('public/c.png').read 
    end
    params.require(:cat).permit(:cat_image, :cat_name, :cat_sex, :cat_age, :cat_weight)
  end
  
  
  
   #==ログインされたユーザーかチェック
  def logged_in_user                       
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
  end
  #==アクセスユーザーとアクセス先のユーザーがあっているか?
  def correct_user
      redirect_to(root_url) unless current_user?(@user)
  end
  # システム管理権限所有かどうか判定します。
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end
