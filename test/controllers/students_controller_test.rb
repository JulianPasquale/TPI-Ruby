#require 'test_helper'

class StudentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    u=User.find_or_create_by(email:'test') do |u|
      u.password='123456'
    end
    sign_in u
    @course= Course.find_or_create_by(name:'Course_students_controller_test', year:Date.today.year)
    @student=Student.find_or_create_by(name:'name',lastname:'lastnam',dni:1234567,number:'151515',course:@course)
    #@student = students(:one)
  end

  test "should get index" do
    get course_students_url(@course)
    assert_response :success
  end

  test "should get new" do
    get new_course_student_url(@course)
    assert_response :success
  end

  test "should create student" do
    assert_difference('Student.count') do
      post course_students_url(@course), params: { student: { course_id: @student.course_id, dni: @student.dni+2, lastname: @student.lastname, name: @student.name, number: "#{@student.number}5" } }
    end

    assert_redirected_to course_url(@course)
    #if not destroy, test will pass just once
    Student.last.destroy
  end

=begin
  Show was disabled
  test "should show student" do
    get student_url(@student)
    assert_response :success
=end


  test "should get edit" do
    get edit_course_student_url(@course,@student)
    assert_response :success
  end

  test "should update student" do
    patch course_student_url(@course,@student), params: { student: { course_id: @student.course_id, dni: @student.dni, lastname: @student.lastname, name: @student.name, number: @student.number } }
    assert_redirected_to course_url(@course)
  end

  test "should destroy student" do
    assert_difference('Student.count', -1) do
      delete course_student_url(@course,@student)
    end

    assert_redirected_to course_url(@course)
  end


end
