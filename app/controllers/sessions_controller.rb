class SessionsController < ApplicationController
  
  def new  #ログインページ
  end
  
  def create  #ログイン機能
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user 
    else
      flash.now[:warning] = 'メールアドレスまたはパスワードが間違ってます。'
      render :new
    end
  end
end
