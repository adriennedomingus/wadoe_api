require "rails_helper"

RSpec.describe StudentEnrollment, type: :model do
  it { should belong_to :school_year }
  it { should belong_to :district }
end
