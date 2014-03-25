# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :commodity do
    commodity_group nil
    name "MyString"
    priority 1
  end
end
