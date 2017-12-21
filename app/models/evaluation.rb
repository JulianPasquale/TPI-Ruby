class Evaluation < ApplicationRecord
  belongs_to :course
  has_many :grades, :dependent => :destroy
  validates :tittle, presence:true, uniqueness: {scope: :course_id, message: "can't be the same twice in a course"}
  validates :min_grade, presence:true, numericality:{greater_than_or_equal_to: -1}
  validates :date, presence:true 
  validates :course_id, presence:true
  after_save :create_grades
  before_save :validate_date
  default_scope { order('date ASC') }

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

  def validate_date
    if (self.date.year < course.year) then
      self.errors.add(:date, "Must be greather than the courses year") 
      throw :abort
    end
  end

  def count_approved
    self.grades.select {|g| g.passed? }.count
  end

  def count_dissaproved
    self.grades.select {|g| (not g.passed?) and (g.grade > -1) }.count
  end

  def count_absent
    self.grades.where("grade = -1").count
  end

  def percentage_approved
    begin
      "#{((self.count_approved) * 100) / (self.grades.count - self.count_absent)}%"
    rescue ZeroDivisionError
      "No student has presented"
    end
  end
  
end
