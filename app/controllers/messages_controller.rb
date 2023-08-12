class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.find(params[:room_id]) #ページのパスが/rooms/:room_id/messagesとなっている。パスにroom_idが含まれているため、paramsというハッシュオブジェクトの中に、room_idという値が存在している。それをparams[:room_id]と書いて取得している。
    @messages = @room.messages.includes(:user) #上で@roomに今いるページのルームを格納しているのでそれを使用。roomテーブルとmessagesテーブルは紐付いているので、多分この書き方で対象のroomのmessagesを取得できるんだと思う。さらに(:user)とすることでユーザー情報をまとめて取得することができる（これはよくわからん）
  end

  def create
    @room = Room.find(params[:room_id]) #今いるroomのインスタンスを生成する。次の@room.messages.newで必要。
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to room_messages_path(@room) #room_messages_pathはroomのidによって変わる。なので今インスタンスを持っているroomのidを記述しなければならない。
    else
      @messages = @room.messages.includes(:user) #messageの投稿に失敗したときにメッセージ一覧に戻れるように定義
      render :index, status: :unprocessable_entity #アクション名に対応するビューを表示。今回だとindex。renderは今持っているデータをそのままもう一度ビューに送るので表示内容が変わらない。
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id) #messageにはuser_idが必要なのでマージして付与している。permitは許可するカラムを指定している。
  end
end
