class Evaluation < ApplicationRecord
  belongs_to :course
  has_many :grades
  validates :tittle, uniqueness: {scope: :course_id, message: "Cant't be the same evaluation twice in a course"}
  
  def to_s
    tittle
  end
end
