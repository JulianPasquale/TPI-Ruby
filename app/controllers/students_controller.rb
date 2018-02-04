class StudentsController < BackendController
  before_action :set_course
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  include FlashHelper

  def index
    @students = @course.students
  end

  def show; end

  def new
    @student = Student.new
  end

  def edit; end

  def create
    @student = @course.students.new(student_params)

      if @student.save
        flash[:success] = t(:success)
        redirect_to course_students_path(@course) 
      else
        flash[:error] = flash_error_format(@student)
        render :new
      end
  end

  def update
      if @student.update(student_params)
        flash[:success] = t(:success)
        redirect_to course_students_path(@course)
      else
        flash[:error] = flash_error_format(@student)
        render :edit 
      end
  end

  def destroy
    @student.destroy
      flash[:success] = t(:success) 
      redirect_to course_students_path(@course) 
  end

  private

  def set_course
    @course=Course.find(params[:course_id])
  end

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:name, :lastname, :dni, :number, :course_id)
  end

end
