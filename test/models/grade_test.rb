#require 'test_helper'

class GradeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "grade passed" do
    @course= Course.find_or_create_by(name:'grade_model_testing', year:Date.today.year)
    @student= @course.students.find_or_create_by(name:'name',lastname:'lastnam',dni:123457,number:'151515')
    @evaluation = @course.evaluations.find_or_create_by(tittle:'Evaluation_grade_test', min_grade:5, date:(Date.today))
    @grade1= Grade.find_by(student:@student,evaluation:@evaluation)
    refute(@grade1.passed?)
    @course.destroy
  end

  test "grade not passed" do
    @course= Course.find_or_create_by(name:'grade_model_test2', year:Date.today.year)
    @student2= @course.students.find_or_create_by(name:'na',lastname:'la',dni:1245678,number:'141419')
    @evaluation = @course.evaluations.find_or_create_by(tittle:'Evaluation_grade_test2', min_grade:5, date:(Date.today))
    @grade2= Grade.find_by(student_id:@student2.id,evaluation_id: @evaluation.id)
    @grade2.grade=8
    @grade2.save
    assert(@grade2.passed?)
    @course.destroy
  end

  test "student can't have 2 grades for the same evaluation" do
    @course= Course.find_or_create_by(name:'grade_model_test3', year:Date.today.year)
    @student= @course.students.find_or_create_by(name:'name',lastname:'lastnam',dni:12347,number:'15151')
    @student2= @course.students.find_or_create_by(name:'names',lastname:'lasts',dni:12345678,number:'14141')
    @evaluation = @course.evaluations.find_or_create_by(tittle:'Evaluation_grade_test', min_grade:5, date:(Date.today))
    @grade= Grade.new(student:@student, evaluation:@evaluation, grade:5)
    refute(@grade.save)
  end

  test "should not create grade" do
    refute(Grade.new.save)
  end

end
