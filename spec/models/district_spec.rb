require 'rails_helper'

RSpec.describe District, type: :model do
  it { should have_many :district_school_years }
  it { should belong_to :county }
  it { should belong_to :educational_service_district }
  it { should have_many :five_year_graduation_rates }
  it { should have_many :student_enrollments }
  it { should have_many :population_demographics }
end
