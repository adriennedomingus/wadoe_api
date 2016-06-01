require "rails_helper"

RSpec.describe ExceptionalStudentService, type: :model do
  it { should belong_to :student_enrollment }
end
