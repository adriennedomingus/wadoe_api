require 'rails_helper'

RSpec.describe CountySchoolYear, type: :model do
  it { should belong_to :school_year }
  it { should have_many :five_year_graduation_rates }
end
