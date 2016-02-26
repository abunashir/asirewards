FactoryGirl.define do
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
