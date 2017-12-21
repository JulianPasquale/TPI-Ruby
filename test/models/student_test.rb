#require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "Student's dni must be unique in a course" do
    @course= Course.find_or_create_by(name:'grade_model_test', year:Date.today.year)
    @student= @course.students.find_or_create_by(name:'name',lastname:'lastnam',dni:12347,number:'15151')
    @student2= @course.students.new(name:'Name',lastname:'lastname',dni:12347,number:'15')
    assert_equal(false,@student2.save)
  end

  test "Student's number must be unique in a course" do
    @course= Course.find_or_create_by(name:'grade_model_test', year:Date.today.year)
    @student= @course.students.find_or_create_by(name:'name',lastname:'lastnam',dni:1234,number:'15')
    @student2= @course.students.new(name:'Name',lastname:'lastname',dni:1234795,number:'15')
    assert_equal(false,@student2.save)
  end

  test "should not create student" do
    assert_equal(false,Student.new.save)
    @course= Course.find_or_create_by(name:'grade_model_test', year:Date.today.year)
    #Student's name is not optional
    @student1= @course.students.new(lastname:'lastnam',dni:1234,number:'15')
    assert_equal(false,@student1.save)
    #Student's lastname is not optional
    @student1= @course.students.new(name:'name',dni:1234,number:'15')
    assert_equal(false,@student1.save)
  end
end
