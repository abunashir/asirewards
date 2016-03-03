FactoryGirl.define do
  factory :certificate do
    banner "Banner Image"
    title "Reward Certificate"
    sub_title "Enjoy unlimited benifits from us"
    terms "Details terms about the certificate"
    expires_on "2016-02-29"
    price "199.99"
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
