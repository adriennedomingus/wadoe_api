require "rails_helper"

RSpec.describe Gender, type: :model do
  it { should belong_to :student_enrollment }
end
