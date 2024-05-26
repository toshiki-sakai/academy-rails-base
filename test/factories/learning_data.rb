FactoryBot.define do
  factory :learning_datum do
    user { nil }
    category { nil }
    skill { "MyString" }
    time { 1 }
    month { "MyString" }
  end
end
