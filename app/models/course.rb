class Course < ApplicationRecord
  has_many :students
  has_many :evaluation

  def to_s
    name
  end
end
