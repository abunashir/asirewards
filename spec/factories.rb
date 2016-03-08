FactoryGirl.define do
  factory :kit do
    association :certificate
    code "ABCD123"

    factory :activation, class: Activation do
      used true
    end
  end

  factory :order do
    association :certificate
    association :user

    quantity 3
    note "Special note"
  end

  factory :certificate do
    association :company

    banner "Banner Image"
    title "Reward Certificate"
    sub_title "Enjoy unlimited benifits from us"
    terms "Details terms about the certificate"
    policies "Basic policies about certificate"
    expires_on "2016-02-29"
    price "199.99"
  end

  factory :company do
    name "Impact Services"

    factory :account, class: Account do
    end
  end

  factory :user do
    association :company

    name "John Doe"
    sequence(:email){ |n| "user#{n}@example.com" }
    password "secret_password"
    role "staff"

    factory :admin do
      admin true
    end
  end
end
