require 'rails_helper'

RSpec.describe County, type: :model do
  it { should have_many :districts }

  it { should have_many :five_year_graduation_rates }
end
