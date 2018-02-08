class RemoveGradeFromGrades < ActiveRecord::Migration[5.1]
  def change
    remove_column :grades, :grade, :float
  end
end
