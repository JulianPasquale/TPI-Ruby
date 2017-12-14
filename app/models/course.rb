class Course < ApplicationRecord
  has_many :students
  has_many :evaluations

  def to_s
    name
  end
end
