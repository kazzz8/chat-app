FactoryBot.define do
  factory :message do
    content {Faker::Lorem.sentence}
    association :user
    association :room

    after(:build) do |message| #afterメソッドで任意の処理の後に指定の処理を実行することができる。今回でいうとインスタンスがbuildされた後に指定の処理を実行する
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end