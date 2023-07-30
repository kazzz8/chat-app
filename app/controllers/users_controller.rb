class UsersController < ApplicationController
  def edit
  end

  def update
    if current_user.update(user_params) #ログインしているユーザーの情報をuser_paramsの値に変更する
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end #多分このifでは成功したらtrueで失敗したらfalseが返ってきてそれを利用しているんだと思う
  end

  private
  def user_params
    params.require(:user).permit(:name,:email) #require(:モデル名)
  end
end
