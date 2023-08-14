require 'rails_helper'

RSpec.describe 'メッセージ投稿機能', type: :system do
  before do
    # 中間テーブルを作成して、usersテーブルとroomsテーブルのレコードを作成する
    @room_user = FactoryBot.create(:room_user) #FactoryBotにはassociationしか書いていないが、中間テーブルを作ったら、associationが組んであるテーブルとそのテーブルのレコードが自動的に作られる。
  end

  context '投稿に失敗したとき' do
    it '送る値が空の為、メッセージの送信に失敗する' do
      # サインインする
      sing_in(@room_user.user) #rails_helper.rbに作ったuser生成からログインまでのメソッド？が実行されている。引数として@room_user.userが渡されている。最後のuserは多分userモデルのインスタンスでemailとかpasswordを持っているんだと思う。

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name) #roomテーブルのnameカラムの情報を取り出している

      # DBに保存されていないことを確認する
      expect{
        find('input[name="commit"]').click
        sleep 1
      }.not_to change{ Message.count } #Messageのレコード数が変わっていないことを確認

      # 元のページに戻ってくることを確認する
      expect(current_path).to eq(room_messages_path(@room_user.room)) #最後の箇所、room.idかと思ったらroomでいいらしい。多分idはメイン？となる要素というか絶対に存在する要素なのでいちいち指定しなくていいのかな

    end
  end
  context '投稿に成功したとき' do
    it 'テキストの投稿に成功すると、投稿一覧に遷移して、投稿した内容が表示されている' do
      # サインインする
      sing_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 値をテキストフォームへ入力する
      post = "テスト"
      fill_in 'message_content', with: post

      # 送信した値がDBに保存されていることを確認する
      expect{
        find('input[name="commit"]').click
        sleep 1
      }.to change{ Message.count }.by(1)

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq(room_messages_path(@room_user.room))

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(post)
    end

    it '画像の投稿に成功すると、投稿一覧に遷移して、投稿した画像が表示されている' do
      # サインインする
      sing_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png') #Rails.rootとすることで、rootディレクトリからこのアプリ(chat-app)のディレクトリまでのパスを取得することができる。それに繋げる形でimage画像のある場所を指定している。joinメソッドを使うことでパス同士をくっつけている。

      # 画像選択フォームに画像を添付する
      attach_file('message[image]', image_path, make_visible: true)

      # 送信した値がDBに保存されていることを確認する
      expect{
        find('input[name="commit"]').click
        sleep 1
      }.to change{ Message.count }.by(1)

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq(room_messages_path(@room_user.room))
      
      # 送信した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector('img')
    end

    it 'テキストと画像の投稿に成功する' do
      # サインインする
      sing_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')

      # 画像選択フォームに画像を添付する
      attach_file('message[image]', image_path, make_visible: true)

      # 値をテキストフォームに入力する
      post = "テスト"
      fill_in 'message_content', with: post

      # 送信した値がDBに保存されていることを確認する
      expect{
        find('input[name="commit"]').click
        sleep 1
      }.to change{ Message.count }.by(1)

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(post)

      # 送信した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector('img')
    end
  end
end
