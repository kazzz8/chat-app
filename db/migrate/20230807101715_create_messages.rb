class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.string :content
      t.references :user, null: false, foreign_key: true #foreign_keyは「外部キー制約」というらしい。その外部キーがないとデータ保存ができない。今回で言えばuserとroomのidが空だと保存できない。
      t.references :room, null: false, foreign_key: true
      t.timestamps
    end
  end
end
