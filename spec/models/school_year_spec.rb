require "rails_helper"

RSpec.describe SchoolYear, type: :model do
  it { should have_many :student_enrollments }
  it { should have_many :five_year_graduation_rates }
  it { should have_many :population_demographics }
end
