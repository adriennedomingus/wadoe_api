require 'rails_helper'

RSpec.describe SchoolYear, type: :model do
  it {should have_many :district_school_years }
end
