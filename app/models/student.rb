class Student < ApplicationRecord
  belongs_to :course
  has_many :grades
  validates :name, presence:true, length:{maximum: 100}
  validates :lastname, presence:true, length:{maximum: 100}
  validates :dni, presence:true, numericality:true, uniqueness:{scope: :course_id, message: "already exists for this course"}
  validates :number, presence:true, length:{maximum: 50}, uniqueness:{scope: :course_id, message: "already exists for this course"}
  after_save :create_grades

  def to_s
    lastname + ' ' + name
  end

  def create_grades
    self.course.evaluations.each do |evaluation|
      g= Grade.new
      g.student_id = self.id
      g.evaluation_id =evaluation.id
      g.save
    end
  end
end
