class ApplicationController < ActionController::Base
  before_action :authenticate_user! #ログイン状態によって表示するページを切り替えるdeviceメソッド。ログインしていなければ、ログイン画面に遷移させられる
  before_action :configure_permitted_parameters, if: :devise_controller? # devise_controller?はdiviseで使えるメソッド。もしdeviseに関するコントローラーの処理のときだけconfi…を実行する。appl…controllerはdevise以外のコントローラーからも読み込まれるが、そのときに実行されないようにこういう条件をつけている

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name]) #ログインやサインアップ画面から送られてきたパラメーターを取得するためのもの。devise専用。
    #普通は params.require(:モデル名).permit(:許可するキー)
    #devise専用 devise_parameter_sanitizer.parmit(:deviseの処理名, keys: [:許可するキー]) やっていることは同じ
  end
end
