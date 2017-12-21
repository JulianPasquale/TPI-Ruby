#require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  test "should create course" do
  	c=Course.new(name:'course_test', year:2017)
    assert_equal(true,c.save)
    c.destroy
  end

  test "should not create course" do
  	c1=Course.new(name:'Course_test1', year:Date.today.year)
    c1.save
    #Already exists
    c2=Course.new(name:'Course_test1', year:Date.today.year)
    #Year must be greater
    c3=Course.new(name:'Course_test1', year:Date.today.year-10)
    assert_equal(false,c2.save)
    assert_equal(false,c3.save)
    c1.destroy
  end

  test "should delete dependents" do
     @course= Course.find_or_create_by(name:'Course_evaluations_model_test', year:Date.today.year)
     @evaluation = @course.evaluations.create(tittle:'Evaluation_year', min_grade:5, date:(Date.today))
     assert_equal(@evaluation, Evaluation.find(@evaluation.id))
     @course.destroy
     assert_equal(false,Evaluation.exists?(@evaluation.id))
  end

  

end

