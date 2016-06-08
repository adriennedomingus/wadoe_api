require 'rails_helper'

RSpec.describe EducationalServiceDistrict, type: :model do
  it { should have_many :districts }
end
