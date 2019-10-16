class UsersController < ApplicationController
  before_action :admin_page,except: [:index,:destroy]
  before_action :set_user,only:[:show,:edit, :destroy, :show_image,:correct_user, :cat_new, ]
  before_action :set_cat,only:[:cat_modal,:cat_delete, :cat_edit, :cat_update, :cat_plan]
  before_action :logged_in_user, only: [:index,:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit,:cat_new,:show]
  before_action :admin_user,only: [:destroy,:index]
  
  

  #ユーザー全表示ページネーション機能持ち
  def index 
    @users = User.paginate(page: params[:page],:per_page => 5)
  end

  def new                   #新規登ページ
    @user = User.new
    
  end
  
  def create                #新規登録
    @user = User.new(user_parameter)
#ファイル選択せれなかった時のための画像    
    obj = File.open('public/user.png').read 
    if @user.save
      if params[:user][:image].nil?
        @user.image = obj
        @user.save
      end  
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
   #ファイル選択せれなかった時のための画像    
    obj = File.open('public/c.png').read 
   
   if @cat.save
     if params[:cat][:cat_image].nil?
        @cat.cat_image = obj
        @cat.save
     end  
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
#ファイル選択せれなかった時のための画像(obj)        
    obj = @cat.cat_image
  if @cat.update_attributes(cat_parameter)
     if params[:cat][:cat_image].nil?
        @cat.cat_image = obj
        @cat.save
     end  
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
   @schedule = @cat.schedules.new
  
end

#各オーナーさん個別ページ

  def show
    @cats = @user.cats.all
  
  end
  
#update  
  def update     
    @user = User.find(params[:id])
#ファイル選択せれなかった時のための画像(obj)        
    obj = @user.image
    if @user.update_attributes(user_parameter)
      if params[:user][:image].nil?
        @user.image = obj
        @user.save
      end  
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
    send_data @user.image,:type => 'image/jpeg'
  end
 #画像バイナリー表示猫
  def cat_show_image  
     @cat = Cat.find(params[:id])
    send_data @cat.cat_image,:type => 'image/jpeg'
  end  

  def facebook_login
      user = User.from_omniauth(request.env["omniauth.auth"])
      obj = User.find_by(email: user.email)
      if obj.nil?
        user.save
        session[:user_id] = user.id
        redirect_to root_url
      end  
      if obj.present?
        session[:user_id] = user.id
        redirect_to user_url @user
      else
        redirect_to login_path
      end
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
       
        data = params[:user][:image].original_filename
        params[:user][:image] = params[:user][:image].read
        image = params[:user][:image]
      
        kakucyousi = File.extname(data)
        if kakucyousi == ".jpg" || kakucyousi == ".jpeg" || kakucyousi == ".png" || kakucyousi == ".gif" ||kakucyousi == ".JPG" || kakucyousi == ".JPEG" || kakucyousi == ".PNG" || kakucyousi == ".GIF"
          image2 = Magick::Image.from_blob(image).first  
          
          rmagick_image = image2.thumbnail(0.5)
          rmagick_image.auto_orient!
          rmagick_image.strip!
          rmagick_image.write('public/make.jpg')
          params[:user][:image] = File.open('public/make.jpg').read
           flash[:success] = "情報更新しました。" 
        #ファイルが画像ファイル以外  
        else
          flash[:danger] = "画像を反映できませんでした。jpg png gif形式を選択ください"
          params[:user][:image] = nil 
        end    
     elsif params[:user][:image].nil?
         
     end
    params.require(:user).permit(:image, :name, :email, :password, :password_confirmation)
  end
  
 #猫パラメーター
  def cat_parameter
    if params[:cat][:cat_image]
        data = params[:cat][:cat_image].original_filename
        params[:cat][:cat_image] = params[:cat][:cat_image].read
        kakucyousi = File.extname(data)
        if kakucyousi == ".jpg" || kakucyousi == ".jpeg" || kakucyousi == ".png" || kakucyousi == ".gif" ||kakucyousi == ".JPG" || kakucyousi == ".JPEG" || kakucyousi == ".PNG" || kakucyousi == ".GIF"
        
            image = params[:cat][:cat_image]
            image2 = Magick::Image.from_blob(image).first 
           
            rmagick_image = image2.thumbnail(0.5)
            rmagick_image.auto_orient!
            rmagick_image.strip!
            rmagick_image.write('public/make2.jpg')
            params[:cat][:cat_image] = File.open('public/make2.jpg').read
        #ファイルが画像ファイル以外      
        else
           flash[:danger] = "画像を反映できませんでした。jpg png gif形式を選択ください"
           params[:cat][:cat_image] = nil 
        end 
    elsif params[:cat][:cat_image].nil?
         
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
