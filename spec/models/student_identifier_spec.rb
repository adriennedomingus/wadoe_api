require 'rails_helper'

RSpec.describe StudentIdentifier, type: :model do
  it { should belong_to :tag }
  it { should have_many :five_year_graduation_rates }
end
