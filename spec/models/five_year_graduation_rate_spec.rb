require 'rails_helper'

RSpec.describe FiveYearGraduationRate, type: :model do
  it { should belong_to :dropout }
  it { should belong_to :district_school_year }
  it { should belong_to :student_identifier }
end
