class Tag < ActiveRecord::Base
  has_many :student_identifiers
end
