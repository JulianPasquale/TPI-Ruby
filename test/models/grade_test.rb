#require 'test_helper'

class GradeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "grade passed" do
    @course= Course.find_or_create_by(name:'grade_model_test', year:Date.today.year)
    @student= @course.students.find_or_create_by(name:'name',lastname:'lastnam',dni:12347,number:'15151')
    @evaluation = @course.evaluations.find_or_create_by(tittle:'Evaluation_grade_test', min_grade:5, date:(Date.today))
    @grade1= Grade.find_by(student_id:@student.id,evaluation_id: @evaluation.id)
    assert_equal(false,@grade1.passed?)
    @course.destroy
  end

  test "grade not passed" do
    @course= Course.find_or_create_by(name:'grade_model_test2', year:Date.today.year)
    @student2= @course.students.find_or_create_by(name:'na',lastname:'la',dni:1245678,number:'141419')
    @evaluation = @course.evaluations.find_or_create_by(tittle:'Evaluation_grade_test2', min_grade:5, date:(Date.today))
    @grade2= Grade.find_by(student_id:@student2.id,evaluation_id: @evaluation.id)
    @grade2.grade=8
    @grade2.save
    assert_equal(true,@grade2.passed?)
    @course.destroy
  end

  test "student can't have 2 grades for the same evaluation" do
    @course= Course.find_or_create_by(name:'grade_model_test', year:Date.today.year)
    @student= @course.students.find_or_create_by(name:'name',lastname:'lastnam',dni:12347,number:'15151')
    @student2= @course.students.find_or_create_by(name:'names',lastname:'lasts',dni:12345678,number:'14141')
    @evaluation = @course.evaluations.find_or_create_by(tittle:'Evaluation_grade_test', min_grade:5, date:(Date.today))
    @grade= Grade.new(student:@student, evaluation:@evaluation, grade:5)
    assert_equal(false,@grade.save)
  end

  test "should not create grade" do
    assert_equal(false,Grade.new.save)
  end

end
