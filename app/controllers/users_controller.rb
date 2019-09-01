class UsersController < ApplicationController
  before_action :set_user,only:[:show,:show_image]
  
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
  
  def user_parameter     #ユーザーのpost patchパラメーター
     if params[:user][:image]
        params[:user][:image] = params[:user][:image].read
     end
    params.require(:user).permit(:image, :name, :email, :password, :password_confirmation)
  end
end
