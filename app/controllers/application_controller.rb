class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include  PostsHelper
  include  MessagesHelper
  include  RecordsHelper
  include  HistoriesHelper
  def admin_page
     if logged_in?
       redirect_to users_url if current_user.admin?
     end  
  end        
   
end
