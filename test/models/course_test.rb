require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  
  def setup
    @course = courses(:curso_uno)
  end

  test "Should create course" do
    assert_difference('Course.count') do
      Course.create(name: (@course.name + '2'), year: @course.year)
    end
  end

  test "should not create course" do
    assert_difference('Course.count', 0) do
      Course.create(name:@course.name, year:@course.year)
    end
    assert_difference('Course.count', 0) do
      Course.create(name:'Course_test1', year:@course.year-10)
    end
  end

  test "should delete dependents" do
     @evaluation = @course.evaluations.first
     assert(@evaluation.persisted?)
     @course.destroy
     refute(Evaluation.exists?(@evaluation.id))
  end

  test "name should be present" do
    @course.name= ''
    refute(@course.valid?)
    assert_includes @course.errors[:name],
      I18n.t('errors.messages.blank')
  end

  test "year should be greater" do
    @course.year= @course.year-10
    refute(@course.valid?)
    assert_includes @course.errors[:year],
      "must be greater than #{(Date.today.year) -1}"
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

