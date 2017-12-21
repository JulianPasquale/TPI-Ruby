#require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  setup do
    u=User.find_or_create_by(email:'test') do |u|
      u.password='123456'
    end
    sign_in (u)
    @course = Course.find_or_create_by(name:'Course_controller_test', year:Date.today.year)
    #@course = courses(:one)
  end

  test "should get index" do
    get courses_url
    assert_response :success
  end

  test "should get new" do
    get new_course_url
    assert_response :success
  end

  test "should create course" do
    assert_difference('Course.count') do
      post courses_url, params: { course: { name: "#{@course.name}_n", year: @course.year } }
    end

    assert_redirected_to course_url(Course.last)
    #if not destroy, test will pass just once
    Course.last.destroy
  end

  test "should show course" do
    get course_url(@course)
    assert_response :success
  end

  test "should get edit" do
    get edit_course_url(@course)
    assert_response :success
  end

  test "should update course" do
    patch course_url(@course), params: { course: { name: @course.name, year: @course.year } }
    assert_redirected_to course_url(@course)
  end

  test "should destroy course" do
    assert_difference('Course.count', -1) do
      delete course_url(@course)
    end
    assert_redirected_to courses_url
  end

end
