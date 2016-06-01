require "rails_helper"

RSpec.describe SchoolYear, type: :model do
  it { should have_many :student_enrollments }
end
