class ExceptionalStudentServiceSerializer < ActiveModel::Serializer
  attributes :percent_special_education,
             :number_special_education,
             :percent_504,
             :number_504
end
