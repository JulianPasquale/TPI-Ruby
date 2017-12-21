#require 'test_helper'

class EvaluationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    u=User.find_or_create_by(email:'test') do |u|
      u.password='123456'
    end
    sign_in u
    @course= Course.find_or_create_by(name:'Course_evaluations_controller_test', year:Date.today.year)
    @evaluation = @course.evaluations.find_or_create_by(tittle:'Evaluation_year', min_grade:5, date:(Date.today))
  end

  test "should get index" do
    get course_evaluations_url(@course)
    assert_response :success
  end

  test "should get new" do
    get new_course_evaluation_url(@course)
    assert_response :success
  end

  test "should create evaluation" do
    assert_difference('Evaluation.count') do
      post course_evaluations_url(@course), params: { evaluation: { course_id: @course.id, date: @evaluation.date, min_grade: 5, tittle: "#{@evaluation.tittle}4" } }
    end

    assert_redirected_to course_url @course
    #if not destroy, test will pass just once
    Evaluation.last.destroy
  end
=begin
  Show was disabled
  test "should show evaluation" do
    get course_evaluation_url(@course,@evaluation)
    assert_response :success
=end

  test "should get edit" do
    get edit_course_evaluation_url(@course,@evaluation)
    assert_response :success
  end

  test "should update evaluation" do
    patch course_evaluation_url(@course,@evaluation), params: { evaluation: { course_id: @evaluation.course_id, date: @evaluation.date, min_grade: @evaluation.min_grade, tittle: @evaluation.tittle } }
    assert_redirected_to course_url(@course)
  end

  test "should destroy evaluation" do
    assert_difference('Evaluation.count', -1) do
      delete course_evaluation_url(@course,@evaluation)
    end

    assert_redirected_to course_url(@course)
  end

end
