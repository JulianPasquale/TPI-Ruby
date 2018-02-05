require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  
  def setup
    @course = courses(:curso_uno)
  end

  test "Should create course" do
    course = Course.create(name: (@course.name + '2'), year: @course.year)
    assert course.valid?
  end

  test "should not be equals courses" do
    course = Course.create(name:@course.name, year:@course.year)

    refute course.valid?
    assert_includes course.errors[:name],
      "This course already exists"
  end
  
  test "course year must be grater than last year" do
    course = Course.create(name:'Course_test1', year:@course.year-10)
    
    refute course.valid?
    assert course.errors.details[:year].any? do |each| 
      each[:error] == :greater_than
    end
  end

  test "should delete dependents" do
     @evaluation = @course.evaluations.first
     assert @evaluation.valid? 

     @course.destroy
     refute Evaluation.exists?(@evaluation.id)
  end

  test "name should be present" do
    @course.name= ''

    refute(@course.valid?)
    assert_includes @course.errors[:name],
      I18n.t('errors.messages.blank')
  end

  test "should delete course" do
    assert_difference('Course.count', -1) do
      @course.destroy
    end
  end

  test "should have grades" do
    assert_not_empty(@course.grades)
  end

  test "should not have grades" do
    curso_cuatro = courses(:curso_cuatro)
    assert_empty(curso_cuatro.grades)
  end

end

