Rails.application.routes.draw do

  get 'sessions/new'

  root "tops#show"                                                                #root
  get '/signup',to: 'users#new'                                                   #会員登録
  
  resources :users do                                                             #ユーザーカラム一式
     resources :posts,only:[:new,:create,:destroy]                    
  end
 
  get 'show_image/:id',to:'users#show_image',as: :show_image                      #イメージ表示
  get    '/login', to: 'sessions#new'                                             #ログインページへ                       
  post   '/login', to: 'sessions#create'                                          #ログイン処理
  delete '/logout', to: 'sessions#destroy'                                        #ログアウト処理
  
  get 'posts',to:'posts#index'                                                    #投稿一覧
  post 'posts',to:'posts#index'   
  get 'newPosts',to: 'posts#new',        as: :new_posts                           #新規投稿
  get 'post_edit/:id',to:'posts#post_edit',as:  :post_edit                        #投稿編集モーダル
  patch 'post_update/:id',to:'posts#post_update', as: :post_update                #モダール編集アップデート
  
  get 'posts/:id/message_show',to:'messages#show',  as: :messages_show            #投稿へのメッセージページへ
  post 'posts/:id/message_create',to:'messages#show',  as: :messages_create       #投稿へのメッセージ登録する
  get 'messege/edit/:msg_id',to:"messages#edit",as: :edit                         #メッセージの編集モーダル
  patch 'messege/update/:msg_id',to:"messages#update",as: :update                 #メッセージの編集アップデート
  delete 'message/delete/:msg_id',to: 'messages#destroy' , as: :delete            #メッセージの削除
  
  get 'replay/show_modal/:msg_id',to:'messages#replay_show',  as: :replay_show    #返信用モーダル
  post 'replay/create/:msg_id',to:"messages#replay_create",   as: :replay_create  #返信登録 
end

