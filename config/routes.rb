Rails.application.routes.draw do
  
  root "tops#show"                                                   #root
  get '/signup',to: 'users#new'                                      #会員登録
  
  resources :users                                                   #ユーザーカラム一式

  get    '/login', to: 'sessions#new'                                #ログインページへ                       
  post   '/login', to: 'sessions#create'                             #ログイン処理
  delete '/logout', to: 'sessions#destroy'                           #ログアウト処理
end

