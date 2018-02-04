class EvaluationsController < BackendController
  before_action :set_course
  before_action :set_evaluation, only: [:show, :edit, :update, :destroy]

  include FlashHelper

  def index
    @evaluations= @course.evaluations
  end

  def show; end

  def new
    @evaluation = @course.evaluations.new
  end

  def edit; end

  def create
    @evaluation = @course.evaluations.new(evaluation_params)

      if @evaluation.save
        flash[:success] = t(:success)
        redirect_to course_evaluations_path(@course)
      else
        flash[:error] = flash_error_format(@evaluation)
        render :new 
      end
  end

  def update
      if @evaluation.update(evaluation_params)
        flash[:success] = t(:success)
        redirect_to course_evaluations_path(@course)
      else
        flash[:error] = flash_error_format(@evaluation)
        render :edit 
      end
  end

  def destroy
    @evaluation.destroy
      flash[:success] = t(:success)
      redirect_to course_evaluations_path(@course)
  end

  private
  
  def set_course
    @course=Course.find(params[:course_id])
  end

  def set_evaluation
    @evaluation = Evaluation.find(params[:id])
  end

  def evaluation_params
    params.require(:evaluation).permit(:tittle, :min_grade, :date, :course_id)
  end
end
