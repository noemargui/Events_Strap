require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
    @user = FactoryBot.create(:user)
  end

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  context "associations" do
    it { expect(@user).to have_many(:attendances) }
    it { expect(@user).to have_many(:events) }
  end
end
