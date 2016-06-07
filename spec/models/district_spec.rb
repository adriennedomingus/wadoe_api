require "rails_helper"

RSpec.describe District, type: :model do
  it { should belong_to :educational_service_district }
  it { should belong_to :county }
  it { should have_many :five_year_graduation_rates }
  it { should have_many :dropouts }
end
