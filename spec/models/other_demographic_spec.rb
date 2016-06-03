require "rails_helper"

RSpec.describe OtherDemographic, type: :model do
  it { should belong_to :student_enrollment }
end
