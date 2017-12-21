#require 'test_helper'

class EvaluationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "evaluation year must greather or equal than course year" do
    c= Course.new(name:'Course_evaluation_year', year:2018)
    c.save
    e1=c.evaluations.new(tittle:'Evaluation_year', min_grade:5, date:(5.years.ago))
    assert_equal(false, e1.save)
    e1.destroy
    c.destroy
  end  

  test "must delete grades" do
    c= Course.new(name:'Course_evaluation_year', year:2018)
    c.save
    e1=c.evaluations.new(tittle:'Evaluation_year', min_grade:5, date:(5.years.ago))    
    e1.save
    s=Student.new(name:'test',lastname:'deleteGrades',dni:12345,number:'12345')
    s.save
    g=e1.grades.new(grade:5, student_id:s.id)
    assert_equal(true,g.save)	
    e1.destroy
    s.destroy
    assert_equal(g,Grade.find(g.id))
  end

end
