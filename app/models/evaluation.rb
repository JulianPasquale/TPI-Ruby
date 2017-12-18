class Evaluation < ApplicationRecord
  belongs_to :course
  has_many :grades, :dependent => :destroy
  validates :tittle, presence:true, uniqueness: {scope: :course_id, message: "can't be the same twice in a course"}
  validates :min_grade, presence:true, numericality:{minimum: -1}
  validates :date, presence:true
  validates :course_id, presence:true
  after_save :create_grades

  def to_s
    tittle
  end

  def create_grades
    self.course.students.each do |student|
      g= Grade.new
      g.student_id = student.id
      g.evaluation_id =self.id
      g.save
    end
  end

  def count_approved
    self.grades.select {|g| g.passed? }.count
  end

  def count_dissaproved
    self.grades.select {|g| (not g.passed?) and (g.grade > -1) }.count
  end

  def count_ausent
    self.grades.where("grade = -1").count
  end

  def percentage_approved
    begin
      "#{((self.count_approved) * 100) / (self.grades.count - self.count_ausent)}%"
    rescue ZeroDivisionError
      "No student has presented"
    end
  end
  
end
