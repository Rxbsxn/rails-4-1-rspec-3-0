FactoryGirl.define do
  factory :phone do
    association :contact
    phone '123-555-1234'

    factory :home_phone do
      phone_type 'home'
    end

    factory :office_phone do
      phone_type 'office'
    end

    factory :mobile_phone do
      phone_type 'mobile'
    end
  end
end
