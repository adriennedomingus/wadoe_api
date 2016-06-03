require "rails_helper"

RSpec.describe StudentEnrollment, type: :model do
  it { should belong_to :school_year }
  it { should belong_to :district }
  it { should have_one :race_ethnicity }
  it { should have_one :exceptional_student_service }
  it { should have_one :other_demographic }
  it { should have_one :gender }
end
