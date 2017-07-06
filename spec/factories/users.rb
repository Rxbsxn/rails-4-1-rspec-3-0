FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'secret12'
    password_confirmation 'secret12'

    factory :admin do
      admin true
    end
  end
end
