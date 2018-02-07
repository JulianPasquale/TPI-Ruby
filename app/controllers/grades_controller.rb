class GradesController < BackendController
  before_action :set_evaluation
  before_action :set_grade, only: [:show, :edit, :update, :destroy]

  def index
    @grades = @evaluation.grades
  end

  def show; end

  def new
    @grade = Grade.new
  end

  def edit; end

  def create
    @grade = Grade.new(grade_params)

    respond_to do |format|
      if @grade.save
        format.html { redirect_to [@evaluation.course], notice: 'Grade was successfully created.' }
        format.json { render :show, status: :created, location: @grade }
      else
        format.html { render :new }
        format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @grade.update(grade_params)
      flash[:success] = t(:success) 
      redirect_to [@evaluation.course]
    else
      flash[:error] = view_context.flash_error_format(@evaluation)
      render :edit 
    end
  end

  def destroy
    @grade.destroy
    respond_to do |format|
      format.html { redirect_to [@evaluation.course], notice: 'Grade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_evaluation
      @evaluation= Evaluation.find(params[:evaluation_id])
    end

    def set_grade
      @grade = Grade.find(params[:id])
    end

    def grade_params
      params.require(:grade).permit(:grade, :student_id, :evaluation_id)
    end
end
