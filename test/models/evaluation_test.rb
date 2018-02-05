require 'test_helper'

class EvaluationTest < ActiveSupport::TestCase

  def setup
    @evaluation = evaluations(:one)
  end
  
  test 'should be valid' do
    assert @evaluation.valid?
    assert_not_nil @evaluation.id
  end

  test 'should create evaluation' do
    evaluation = Evaluation.create(
      tittle: "#{@evaluation.tittle + '5'}", 
      min_grade: 5, 
      date: @evaluation.date + 1.years,
      course: @evaluation.course
    )
   
    assert evaluation.persisted?
  end

  test "year must greater or equal than course year" do
    @evaluation.date= (@evaluation.date - 10.years)
 
    refute @evaluation.valid?
    assert_includes @evaluation.errors[:date],
      "must be greather than the courses year"
  end  

  test "should update evaluation" do
    @evaluation.update( tittle: 'new_tittle', min_grade: 8)
    assert @evaluation.valid?
    assert_equal 'new_tittle', @evaluation.tittle
  end

  test "should not create evaluation" do
    evaluation = Evaluation.create( 
      tittle: @evaluation.tittle,
      min_grade: 5,
      date: @evaluation.date,
      course: @evaluation.course
    )

    refute evaluation.valid?
    assert_includes evaluation.errors[:tittle],
      "can't be the same twice in a course"
  end

  test "count of approved" do
    assert_equal(1,evaluations(:two).count_approved)
    assert_equal(0,@evaluation.count_approved)
  end

  test "count of disapproved" do
    assert_equal(0,evaluations(:two).count_disapproved)
    assert_equal(1,@evaluation.count_disapproved)
  end

  test "count of absents" do
    assert_equal(1,evaluations(:two).count_absent)
    assert_equal(0,@evaluation.count_absent)
  end
end
