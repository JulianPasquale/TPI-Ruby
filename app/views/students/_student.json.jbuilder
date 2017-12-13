json.extract! student, :id, :name, :lastname, :dni, :number, :course_id, :created_at, :updated_at
json.url student_url(student, format: :json)
