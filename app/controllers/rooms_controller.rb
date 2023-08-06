class RoomsController < ApplicationController
  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params) #引数にメソッドを指定することができる
    if @room.save #保存が成功したらtrueが返るので、ifの条件が実行される
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity #statusオプション unpro…は失敗したときにエラーメッセージを表している。多分このメッセージが来たときだけrenderを実行するんだと思う
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, user_ids:[]) #Roomモデルにデータ保存すると同時に中間テーブルのuser_idsにもデータが保存されるらしい。ここでは配列に格納されているそのチャットルームに参加するuser2名分のID
  end
end