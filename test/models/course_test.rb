#require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  test "should create course" do
  	c=Course.new(name:'course_test', year:2017)
    assert_equal(true,c.save)
    c.destroy
  end

  test "should not create course" do
  	c1=Course.new(name:'Course_test1', year:2017)
    c1.save
    c2=Course.new(name:'Course_test1', year:2017)
    c3=Course.new(name:'Course_test1', year:2010)
    assert_equal(false,c2.save)
    assert_equal(false,c3.save)
    c1.destroy
    c2.destroy
  end

  test "should delete dependents" do
     @course= Course.find_or_create_by(name:'Course_evaluations_model_test', year:Date.today.year)
     @evaluation = @course.evaluations.find_or_create_by(tittle:'Evaluation_year', min_grade:5, date:(Date.today))
     assert_equal(@evaluation, Evaluation.last)
     @course.destroy
     assert_not_equal(Evaluation.last,@evaluation)
  end

  

end

