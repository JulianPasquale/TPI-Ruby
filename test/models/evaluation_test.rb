#require 'test_helper'

class EvaluationTest < ActiveSupport::TestCase

  test "evaluation year must greater or equal than course year" do
    c= Course.new(name:'Course_evaluation_year', year:2018)
    c.save
    e1=c.evaluations.new(tittle:'Evaluation_year', min_grade:5, date:(5.years.ago))
    assert_equal(false, e1.save)
    e1.destroy
    c.destroy
  end  

  test "must delete grades" do
    c= Course.new(name:'Course_evaluation_grades', year:Date.today.year)
    c.save
    e1=Evaluation.new(tittle:'Evaluation_year', min_grade:5, date:Date.today,course:c)    
    e1.save
    s=Student.new(name:'name',lastname:'lastnam',dni:1234567,number:'151515',course:c)
    s.save
    assert_equal(true,Grade.where('evaluation_id=?',e1.id).exists?)	
    e1.destroy
    s.destroy
    c.destroy
    assert_equal(false,Grade.where('evaluation_id=?',e1.id).exists?)
  end

  test "should not add evaluation" do
    c= Course.new(name:'Course_evaluation_nc', year:Date.today.year)
    c.save
    e1=Evaluation.new(tittle:'EvaluationNotc1', min_grade:5, date:2.years.ago,course:c)    
    assert_equal(false,e1.save)
    e2= Evaluation.new(tittle:'EvaluationNotc2', min_grade:-15, date:Date.today,course:c)
    assert_equal(false,e2.save)
    c.destroy
    e1.destroy
    e2.destroy
  end

end
