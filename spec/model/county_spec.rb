require "rails_helper"

RSpec.describe County, type: :model do
  it { should have_many :districts }
end
