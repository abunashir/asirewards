FactoryGirl.define do
  factory :purchase do
    association :user
    association :certificate
    payment_id "PAY-7KV41762LX957861GK3LMH6A"
  end

  factory :booking do
    association :destination
    association :kit
    check_in "2016-03-21"
    adults 2
    children 0
    contact "+1888123123"
    note ""
    confirmation_code "ABCD1234"
  end

  factory :destination do
    name "Raddission Blue"
    banner "image"
    content "This is the details description about the destination"
    location "Bangkok"
    country "Thailand"
    active true
  end

  factory :content do
    association :certificate
    title "Certificat title"
    sub_title "Certificate Sub title"
    terms "Details tersm section"
    policies "Details policy section"
  end

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
    name "Reward Certificate"
    price "199.99"
    expires_in 12
    duration 7
  end

  factory :company do
    name "Impact Services"

    factory :account, class: Account do
    end

    factory :owner_company do
      owner true
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
