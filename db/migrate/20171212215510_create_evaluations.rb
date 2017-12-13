class CreateEvaluations < ActiveRecord::Migration[5.1]
  def change
    create_table :evaluations do |t|
      t.string :tittle
      t.float :min_grade
      t.date :date
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
