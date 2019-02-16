FactoryBot.define do
  factory :attendance do
    stripe_customer_id { "MyString" }
    event {FactoryBot.create(:event)}
    attendee {FactoryBot.create(:user)}
  end
end
