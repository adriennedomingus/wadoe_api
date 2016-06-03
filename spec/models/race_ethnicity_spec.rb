require "rails_helper"

RSpec.describe RaceEthnicity, type: :model do
  it { should belong_to :student_enrollment }
end
