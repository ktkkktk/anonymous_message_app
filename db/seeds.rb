user = User.create!(email: 'test@test.com',
            password: 'test', activated: "true", activated_at: Time.zone.now)
user.message_cards.create!(content: "Hello, world")
long_jp = 'あ' * 300
user.message_cards.create!(content: long_jp)
            
30.times do |n|
  content = Faker::Lorem.sentence
  User.first.message_cards.create!(content: content)
end