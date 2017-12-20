#require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  test "should create course" do
  	c=Course.new(name:'course_test', year:2017)
    assert_equal(true,c.save)
    c.destroy
  end

  test "should not create course" do
  	c1=Course.new(name:'Course_test', year:2017).save
    c2=Course.new(name:'Course_test', year:2017)
    assert_equal(false,c2.save)
    c1.destroy
    c2.destroy
  end

  test "should delete dependents" do
    c= Course.create(name:'Course_evaluation', year:2020)
    e=c.evaluations.create!(id:101,tittle:'testing', min_grade:4, date:Date.today)
    assert_equal(true, e.save)
    assert_equal(true, Evaluation.find(101).empty?)
    c.destroy
    assert_equal(Course.last,c)
    e.destroy
  end
  

end
