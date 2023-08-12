class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_one_attached :image #has_one_attachedはレコードとファイルを1対1の関係で紐付けるメソッド。この場合、messageとimageが1対1の関係として紐付けられる

  validates :content, presence: true
end
