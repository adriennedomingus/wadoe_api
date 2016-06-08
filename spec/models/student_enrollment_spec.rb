require 'rails_helper'

RSpec.describe StudentEnrollment, type: :model do
  it { should have_one :district_school_year }
  it { should have_one :school_year }
  it { should have_one :district }
end
