Rails.application.routes.draw do
  

  get 'sessions/new'

  root "tops#show"                                                   #root
  get '/signup',to: 'users#new'                                      #会員登録
  
  resources :users do                                                #ユーザーカラム一式
     resources :posts,only:[:new,:create]                    
  end
 
  get 'show_image/:id',to:'users#show_image',as: :show_image         #イメージ表示
  get    '/login', to: 'sessions#new'                                #ログインページへ                       
  post   '/login', to: 'sessions#create'                             #ログイン処理
  delete '/logout', to: 'sessions#destroy'                           #ログアウト処理
  
  get 'posts',to:'posts#index'                                       #投稿一覧
  get 'newPosts',to: 'posts#new',        as: :new_posts              #新規投稿
  
  
  
  
end

