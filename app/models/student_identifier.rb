class StudentIdentifier < ActiveRecord::Base
  belongs_to :tag
  has_many   :five_year_graduation_rates
end
