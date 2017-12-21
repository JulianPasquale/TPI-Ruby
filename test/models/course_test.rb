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

#  test "should delete dependents" do
#    c=Course.new(name:'Coue_evaltion8115', year:2022)
#    c.save
#    e=Evaluation.new(tittle:'teig90880', min_grade:4, date:Date.today,course_id:c.id)
#    assert_equal(true, e.save)
#    assert_equal(e, Evaluation.last)
#    c.destroy
#    assert_equal(Course.last,c)
#    e.destroy
#  end

  

end

