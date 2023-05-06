Rails.application.routes.draw do
# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
namespace :admin do
  #devise_for...Deviseを使って認証を行うためのルーティングを自動的に生成するためのヘルパーメソッド
  #:adminsというシンボルを受け取り、:adminsという名前のモデルを扱う
  #:registrationsと:passwordsをスキップするオプションが渡されているため、ユーザーの登録やパスワードのリセットを行う機能が無効化
  #:sessionsコントローラーの名前をadmin/sessionsに変更するためのオプションが渡されています。これにより、管理者用のログイン画面を別途用意することができる
  #path: ''ルートパスのパス名が空文字列に設定され、管理者ログインページへのURLが/admins/sign_inになる
  #path_namesオプションでは、デフォルトのパス名を変更している
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {sessions: "admin/sessions"}, path: '', path_names: { sign_in: 'sign_in', sign_out: 'sign_out'}
  
  get '', to: 'customers#index' #管理者トップページ会員一覧
  resources :customers, except: [:new, :create, :destroy]
  
  resources :gifts, only: [:index, :create, :edit, :update]do
    resources :comment, only: [:destroy]
  end
  
  resources :scenes, only: [:index, :create, :edit, :update]
   
  resources :customers, except: [:new, :create, :destroy]
  
  
  
  
 end
end
