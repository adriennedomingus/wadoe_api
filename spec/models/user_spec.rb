require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email}
  it { should validate_uniqueness_of :email}
  it { should validate_uniqueness_of :api_key}

  it "generates a new api key" do
    user = User.create(email: "example@exmaple.com", password: "password")
    expect(user.api_key).to equal(nil)

    user.generate_api_key

    expect(user.api_key.length).to equal(32)
  end

  it "changes a users already existing api key" do
    initial_key = "9dc931099724579a6ab7361859130160"
    user = User.create(email: "example@example.com", password: "password", api_key: initial_key)

    expect(user.api_key).to eq(initial_key)

    user.generate_api_key

    expect(user.api_key).to_not eq(initial_key)
  end
end
