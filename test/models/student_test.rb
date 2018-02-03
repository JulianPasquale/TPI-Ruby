require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  
  def setup
    @student = students(:one)
  end
  
  test "should create student" do
    student = Student.create(
      name: 'Estudiante', 
      lastname: 'numero 10',
      dni: (@student.dni + 100),
      number: "#{@student.number + '1321/2'}",
      course: @student.course
    )
    assert student.persisted?
  end

  test "Student's dni must be unique in a course" do
    student = Student.create(
      name: 'Name',
      lastname: 'lastname',
      dni: @student.dni,
      number: "#{@student.number + '1321/2'}",
      course: @student.course
    )

    refute student.valid?
    assert_includes student.errors[:dni], 
      "already exists for this course"
  end


  test "Student's number must be unique in a course" do
    student = Student.create(
      name: 'Name',
      lastname: 'lastname',
      dni: (@student.dni + 20),
      number: @student.number,
      course: @student.course
    )

    refute student.valid?
    assert_includes student.errors[:number], 
      "already exists for this course"
  end

end
