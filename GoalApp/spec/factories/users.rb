FactoryBot.define do
  factory :user do
    username 'bob'#Faker::Internet.user_name
    password 'password'
  end
end
