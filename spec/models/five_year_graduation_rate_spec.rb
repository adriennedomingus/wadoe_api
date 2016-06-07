require 'rails_helper'

RSpec.describe FiveYearGraduationRate, type: :model do
  it { should belong_to :district }
  it { should belong_to :school_year }
  it { should belong_to :student_identifier }
  it { should belong_to :dropout }
end
