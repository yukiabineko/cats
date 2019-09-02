class UsersController < ApplicationController
  before_action :set_user,only:[:show,:edit,:show_image]
  
  def index
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

  def show
  end
  
  def show_image  #画像バイナリー表示
    send_data @user.image
  end
private

  def set_user                                                                  #個別ユーザー呼び出し
    @user = User.find(params[:id] )
  end
  
  def user_parameter     #ユーザーのpost patchパラメーター    rmasicで処理
     if params[:user][:image]
        params[:user][:image] = params[:user][:image].read
        image = params[:user][:image]
        rmagick_image = Magick::Image.from_blob(image).first
        rmagick_image.auto_orient!
        rmagick_image.strip!
        rmagick_image.write('public/make.jpg')
        params[:user][:image] = File.open('public/make.jpg').read
     elsif params[:user][:image].nil?
         params[:user][:image] = File.open('public/user.png').read 
     end
    params.require(:user).permit(:image, :name, :email, :password, :password_confirmation)
  end
end
