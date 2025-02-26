Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root 'static_pages#top'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'terms_of_use', to: 'static_pages#terms_of_use'

  get 'login', to: 'user_sessions#new' , as: :login
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy', as: :logout

  # 管理者用のルーティングを先に定義
  namespace :admin do
    get 'top', to: 'dashboards#top'
    resources :users,  except: [:show, :destroy]
    resources :items
    # resources :histories
  end

  # 一般ユーザー用のルーティング
  resources :users, only: [:new, :show, :edit, :update], param: :uuid do
    member do
      get 'edit_password'
      patch 'update_password'
    end
  end

  # usersのindexページのリダイレクト（管理者用ルーティングの後に配置）
  get '/users', to: redirect('/')
  # /users/new へのアクセスを管理者ページまたはホームにリダイレクト
  get '/users/new', to: redirect('/admin/users/new')  # または to: redirect('/')

  resources :items
  resources :send_lists
  post 'send_sms', to: 'send_lists#create', as: 'send_sms'

  resources :password_resets, param: :token, only: [:new, :create, :edit, :update]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  # 定義されていない全てのパスを404ページにリダイレクト
  match '*path', via: :all, to: 'static_pages#not_found'
end
