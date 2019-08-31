module SessionsHelper
    
  def log_in(user)           #session id格納
    session[:user_id] = user.id
  end    
  
  def current_user          #ログインユーザ定義
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  
  def logged_in?            #ログインしているか?(current_userがなければfalse)
    !current_user.nil?
  end
  
end
