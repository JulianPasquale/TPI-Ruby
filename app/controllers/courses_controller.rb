class CoursesController < BackendController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    @courses = Course.all
    session.delete(:actual_course)
    session.delete(:actual_evaluation)
  end

  def show
    if params[:course_id] then
      @param = params[:course_id]
    else
      @param = params[:id]  
    end
    session[:actual_course] = @param
  end

  def new
    @course = Course.new
  end

  def edit; end

  def create
    @course = Course.new(course_params)

      if @course.save
        flash[:success] = t(:success)
        redirect_to @course
      else
        flash[:error] = view_context.flash_error_format(@course)
        render :new 
      end
  end

  def update
    if @course.update(course_params)
      flash[:success] = t(:success)
      redirect_to @course
    else
      flash[:error] = view_context.flash_error_format(@course)
      render :edit
    end
  end

  def destroy
    @course.destroy
    
    flash[:success] = t(:success)
    redirect_to courses_url
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:year, :name)
  end

end
