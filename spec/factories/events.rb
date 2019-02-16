FactoryBot.define do
  factory :event do
    start_date { "2019-02-28" }
    duration { 25 }
    title { "My title" }
    description { "My super Description !" }
    price { 20 }
    location { "Paris" }
    administrator {FactoryBot.create(:user)}
  end
end
