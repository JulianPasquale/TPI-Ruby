require 'test_helper'

class GradeTest < ActiveSupport::TestCase
  
  test "grade passed" do
    assert grades(:c1_est2).passed?
  end

  test "grade not passed" do
    refute grades(:c1_est1).passed?
  end

  test "student can't have 2 grades for the same evaluation" do
    grade = Grade.create(
      student: grades(:c1_est1).student, 
      evaluation: grades(:c1_est1).evaluation, 
      grade:5)
   
    refute grade.valid?
    assert grade.errors.details[:student_id].any? do |each| 
      each[:error] == :taken
    end
  end

  test "should create grade in absent" do
    grade = Grade.create(
      student: students(:six), 
      evaluation: evaluations(:one)
    )

    assert grade.valid?
    assert_equal(-1, grade.grade)    
  end

end
