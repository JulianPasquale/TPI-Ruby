class Evaluation < ActiveRecord::Base
  default_scope { order('date ASC') }

  belongs_to :course
  has_many :grades, dependent: :destroy
  has_many :students, through: :course
  
  validates :tittle, presence:true, uniqueness: {scope: :course_id, message: I18n.t(:taken)}
  validates :min_grade, presence:true, numericality:{greater_than_or_equal_to: -1}
  validates :date, presence:true 
  validates :course_id, presence:true
  after_create :create_grades
  validate :validate_date
  

  def to_s
    tittle
  end

  def create_grades
    self.course.students.each do |student|
      grades.create student: student
    end
  end

  def validate_date
    if (date.year <= course.year) then
      errors.add(:date, :greater_than_or_equal_to, count: course.year) 
    end
  end

  def count_approved
    grades.select {|g| g.passed? }.count
  end

  def count_disapproved
    grades.select {|g| g.grade && !g.passed? }.count
  end

  def count_absent
    grades.where(grade: nil).count
  end

  def percentage_approved
    begin
      "#{((self.count_approved) * 100) / (self.grades.count - self.count_absent)}%"
    rescue ZeroDivisionError
      "No student has presented"
    end
  end
  
end
