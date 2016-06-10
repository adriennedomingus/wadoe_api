require 'rails_helper'

RSpec.describe DistrictSchoolYear, type: :model do
  it { should belong_to :school_year }
  it { should belong_to :district }
  it { should belong_to :student_enrollment }
  it { should have_many :five_year_graduation_rates }
  it { should have_many :population_demographics }
end
