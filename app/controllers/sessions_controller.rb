class SessionsController < ApplicationController
  
  def new  #ログインページ
  end

  def create2
    user = User.from_omniauth(request.env["omniauth.auth"])
    obj = User.find_by(email: user.email)
    if obj.nil?
      user.save
    end  
    if user.save || obj.present?
      session[:user_id] = user.id
      redirect_to root_url
    else
      redirect_to login_path
    end
  end

  def destroy2
    session[:user_id] = nil
    redirect_to new_session_path
  end



  
  def create  #ログイン機能
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
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
