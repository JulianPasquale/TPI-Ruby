class CreateGrades < ActiveRecord::Migration[5.1]
  def change
    create_table :grades do |t|
      t.float :grade, null:false, default: -1
      t.references :student, foreign_key: true
      t.references :evaluation, foreign_key: true

      t.timestamps
    end
  end
end
