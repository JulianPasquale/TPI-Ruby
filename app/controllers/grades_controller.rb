class GradesController < BackendController
  before_action :set_grade, only: :update

  def update
    binding.pry
    if @grade.update(grade_params)
      flash[:success] = t(:success) 
    else
      flash[:error] = view_context.flash_error_format(@evaluation)
    end
  end

  private

    def set_grade
      @grade = Grade.find(params[:id])
    end

    def grade_params
      params.require(:grade).permit(:grade, :student_id, :evaluation_id)
    end
end
