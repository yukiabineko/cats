class SessionsController < ApplicationController
  
  def new  #ログインページ
  end
  
  def create  #ログイン機能
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
       params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to root_url
    else
      flash.now[:warning] = 'メールアドレスまたはパスワードが間違ってます。'
      render :new
    end
  end
  
  def destroy        #ログアウト機能
  
    log_out if logged_in?
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
end
