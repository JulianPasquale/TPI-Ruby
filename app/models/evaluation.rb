class Evaluation < ApplicationRecord
  belongs_to :course
  has_many :grades
  
  def to_s
    tittle
  end
end
