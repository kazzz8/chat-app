class Room < ApplicationRecord
  has_many :room_users, dependent: :destroy #userを消してはいけない。room_usersテーブルのレコードを消す
  has_many :users, through: :room_users
  has_many :messages, dependent: :destroy #dependentは「依存している」という意味。つまりmessagesはroomに依存しているということになる。そしてdestroyを指定することで、roomが削除されたときにmessagesも一緒に削除されるということになる。

  validates :name, presence: true
  
end
