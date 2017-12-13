class Student < ApplicationRecord
  belongs_to :course
  has_many :grades
 
  def to_s
    number
  end
end
