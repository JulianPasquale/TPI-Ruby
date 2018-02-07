class GradesController < BackendController
  before_action :set_grade, only: :update

  def update
    @grade.update(grade_params)
  end

  private

    def set_grade
      @grade = Grade.find(params[:id])
    end

    def grade_params
      params.permit(:grade, :student_id, :evaluation_id)
    end
end
