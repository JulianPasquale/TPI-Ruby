#require 'test_helper'

class EvaluationTest < ActiveSupport::TestCase

  test "evaluation year must greater or equal than course year" do
    c= Course.find_or_create_by(name:'Course_evaluation_year', year:2018)
    e1=c.evaluations.new(tittle:'Evaluation_year', min_grade:5, date:(5.years.ago))
    refute(false, e1.save)
    c.destroy
  end  

  test "should delete grades" do
    c= Course.find_or_create_by(name:'Course_evaluation_grades_test', year:Date.today.year)
    e1=c.evaluations.find_or_create_by(tittle:'Evaluation_year', min_grade:5, date:Date.today)    
    s=c.students.find_or_create_by(name:'name',lastname:'lastnam',dni:1234567,number:'151515')
    assert(Grade.where('evaluation_id=?',e1.id).exists?)	
    #e1.destroy
    #s.destroy
    c.destroy
    refute(false,Grade.where('evaluation_id=?',e1.id).exists?)
  end

  test "should not add evaluation" do
    c= Course.find_or_create_by(name:'Course_evaluation_nc', year:Date.today.year)
    #Year must be greater or equal than course's year
    e1=Evaluation.new(tittle:'EvaluationNotc1', min_grade:5, date:2.years.ago,course:c)    
    refute(e1.save)
    #min_grade must be greater than -1
    e2= Evaluation.new(tittle:'EvaluationNotc2', min_grade:-15, date:Date.today,course:c)
    refute(e2.save)
    c.destroy
  end

  test "count of approved" do
    @course= Course.find_or_create_by(name:'Course_evaluation_c_approved', year:Date.today.year)
    @student= @course.students.find_or_create_by(name:'name',lastname:'lastn',dni:1234567,number:'151515')
    @student2= @course.students.find_or_create_by(name:'name2',lastname:'last',dni:12345678,number:'141414')
    @evaluation = @course.evaluations.find_or_create_by(tittle:'Evaluation_countApproved', min_grade:5, date:(Date.today))
    @evaluation2 = @course.evaluations.find_or_create_by(tittle:'Evaluation_countApproved2', min_grade:6, date:(Date.today))
    @grade1=@evaluation2.grades.first
    @grade1.grade=9
    @grade1.save
    assert_equal(1,@evaluation2.count_approved)
    assert_equal(0,@evaluation.count_approved)
    #@evaluation.destroy
    #@evaluation2.destroy
    #@student.destroy
    #@student2.destroy
    @course.destroy
  end

  test "count of disapproved" do
    @course= Course.find_or_create_by(name:'Course_evaluation_c_approved', year:Date.today.year)
    @student= @course.students.find_or_create_by(name:'name',lastname:'lastn',dni:1234567,number:'151515')
    @student2= @course.students.find_or_create_by(name:'name2',lastname:'last',dni:12345678,number:'141414')
    @evaluation = @course.evaluations.find_or_create_by(tittle:'Evaluation_countApproved', min_grade:5, date:(Date.today))
    @evaluation2 = @course.evaluations.find_or_create_by(tittle:'Evaluation_countApproved2', min_grade:6, date:(Date.today))
    @grade1=@evaluation2.grades.first
    @grade1.grade=2
    @grade1.save
    @grade2=@evaluation2.grades.last
    @grade2.grade=2
    @grade2.save
    assert_equal(2,@evaluation2.count_disapproved)
    assert_equal(0,@evaluation.count_disapproved)
    @course.destroy
  end

  test "count of absents" do
    @course= Course.find_or_create_by(name:'Course_evaluation_c_approved', year:Date.today.year)
    @student= @course.students.find_or_create_by(name:'name',lastname:'lastn',dni:1234567,number:'151515')
    @student2= @course.students.find_or_create_by(name:'name2',lastname:'last',dni:12345678,number:'141414')
    @evaluation = @course.evaluations.find_or_create_by(tittle:'Evaluation_countApproved', min_grade:5, date:(Date.today))
    @evaluation2 = @course.evaluations.find_or_create_by(tittle:'Evaluation_countApproved2', min_grade:6, date:(Date.today))
    @grade1=@evaluation2.grades.first
    @grade1.grade=9
    @grade1.save
    assert_equal(1,@evaluation2.count_absent)
    assert_equal(2,@evaluation.count_absent)
    #@evaluation.destroy
    #@evaluation2.destroy
    #@student.destroy
    #@student2.destroy
    @course.destroy
  end
end
