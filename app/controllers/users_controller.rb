class UsersController < ApplicationController
  before_action :set_user,only:[:show]
  
  def index
  end

  def new                   #新規登ページ
    @user = User.new
    
  end
  
  def create                #新規登録
    @user = User.new(user_parameter)
    if @user.save
      
    else
      render :new
    end  
  end

  def edit
  end

  def show
  end
private

  def set_user                                                                  #個別ユーザー呼び出し
    @user = User.find(params[:id] )
  end
  
  def user_parameter     #ユーザーのpost patchパラメーター
    params.require(:user).permit(:image, :name, :email, :password, :password_confirmation)
  end
end
