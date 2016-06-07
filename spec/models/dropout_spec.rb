require 'rails_helper'

RSpec.describe Dropout, type: :model do
  it { should have_one :five_year_graduation_rate }
end
