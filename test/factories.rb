FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "User_#{n}" }
    password "testpassword"
    password_confirmation { |u| u.password }
    token { |u| User.generate_token(u.username) }
  end

  factory :headline do
    sequence(:title) { |n| "Headline #{n}" }
    sequence(:content) { |n| "This is the content of headline \##{n}." }
  end

  factory :comment do
    association :user
    content "This is a test comment."
  end

  factory :screenshot do
    title "Test screenshot"
    description "Description of test screenshot"
    image { fixture_file_upload(File.join(Rails.root, 'test/fixtures/Creeper.png'), 'image/png') }
  end

  factory :category do
    title "Test category"
  end

  factory :forum do
    title "Test forum"
    description "Test forum description"
  end

  factory :topic do
    title "Test topic"
  end
end
