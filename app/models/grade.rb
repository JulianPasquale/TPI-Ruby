class Grade < ApplicationRecord
  belongs_to :student
  belongs_to :evaluation
  validates :grade, presence:true, numericality: {greater_than_or_equal_to:-1}
  validates :student_id, presence:true, uniqueness:{scope: :evaluation_id, message:"can't have more than one grade for the same evaluation"}
  validates :evaluation_id, presence:true

  def passed?
  	grade >= (evaluation.min_grade)
  end	
end
