class AddGradeToGrades < ActiveRecord::Migration[5.1]
  def change
    add_column :grades, :grade, :float
  end
end
