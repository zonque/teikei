# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :translation do
    title "MyString"
    locale "MyString"
    translatable nil
  end
end
