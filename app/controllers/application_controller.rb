class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include  PostsHelper
  include  MessagesHelper
end
