#require 'test_helper'

class GradesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    u=User.find_or_create_by(email:'test') do |u|
      u.password='123456'
    end
    sign_in u
    @course= Course.find_or_create_by(name:'Course_controller_test', year:Date.today.year)
    @student= @course.students.find_or_create_by(name:'name',lastname:'lastnam',dni:1234567,number:'151515')
    @student2= @course.students.find_or_create_by(name:'name2',lastname:'last',dni:12345678,number:'141414')
    @evaluation = @course.evaluations.find_or_create_by(tittle:'Evaluation_year', min_grade:5, date:(Date.today))
    @grade= Grade.select{ |g| (g.evaluation_id=@evaluation.id) and (g.student_id=@student.id) }
  end

  test "should get index" do
    get (course_evaluation_grades_url(@course,@evaluation))
    assert_response :success
  end

=begin
  test "should get new" do
    get new_course_evaluation_grade_url(@course,@evaluation)
    assert_response :success
  end


  test "should create grade" do
    assert_difference('Grade.count') do
      post (course_evaluation_grades_url(@course,@evaluation)), params: { grade: { evaluation: @evaluation, grade: 8, student: @student2 } }
    end

    assert_redirected_to course_url(@course)
    #if not destroy, test will pass just once
    Grade.last.destroy
  end
=end

=begin
  Show was disabled
  test "should show grade" do
    get grade_url(@grade)
    assert_response :success
  end
=end


  test "should get edit" do
    get edit_course_evaluation_grade_url(@course,@evaluation,@grade)
    assert_response :success
  end

  test "should update grade" do
    patch course_evaluation_grade_url(@course,@evaluation,@grade), params: { grade: { evaluation_id: @evaluation.id, grade: 5, student_id: @student.id } }
    assert_redirected_to course_url(@course)
  end

=begin
  Destroy was disabled
  test "should destroy grade" do
    assert_difference('Grade.count', -1) do
      delete grade_url(@grade)
    end

    assert_redirected_to grades_url
  end
=end
end
