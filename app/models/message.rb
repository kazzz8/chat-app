class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_one_attached :image #has_one_attachedはレコードとファイルを1対1の関係で紐付けるメソッド。この場合、messageとimageが1対1の関係として紐付けられる

  validates :content, presence: true, unless: :was_attached? #バリデーションに引っかかった場合(False)でも、unlessの条件をつけているので、was_attached?メソッドで再判定している。再判定の結果Trueとなった場合、ユーザーから送信された情報を保存する。

  def was_attached?
    self.image.attached? #imageに値があればTrueを返す。今回の場合imagaとはイコール画像のファイルのパス
  end
end
