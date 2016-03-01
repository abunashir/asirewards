FactoryGirl.define do
  factory :certificate do
    banner "MyString"
    title "MyText"
    sub_title "MyText"
    terms "MyText"
    expires_on "2016-02-29"
    price "9.99"
  end
  factory :company do
    name "Impact Services"

    factory :account, class: Account do
    end
  end

  factory :user do
    name "John Doe"
    sequence(:email){ |n| "user#{n}@example.com" }
    password "secret_password"
  end
end
