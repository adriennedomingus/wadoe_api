require "rails_helper"

RSpec.describe District, type: :model do
  it { should belong_to :educational_service_district }
  it { should belong_to :county }
end
