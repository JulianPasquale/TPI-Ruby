User.create(
  email: "admin@gmail.com", 
  password: "123456", 
  password_confirmation: "123456" 
)

c1 = Course.create!(
  name: "Ruby- Primer semestre",
  year: (Date.today.year)
)

c2 = Course.create!(
  name: "Ruby- Segundo Semestre",
  year: (Date.today.year)
)

c3 = Course.create!(
  name: "Ruby- Primer semestre",
  year: (Date.today.year + 1)
)

c4 = Course.create!(
  name: "Ruby- Segundo semestre",
  year: (Date.today.year + 1)
)


6.times do |i|
  Student.create!(
    name: "#{i}", lastname: "Estudiante", 
    dni: (i*1000), number: "#{i}",
    course: c1
  )
end


4.times do |i|
  Student.create!(
    name: "#{i}", lastname: "Estudiante", 
    dni: (i*1000), number: "#{i}",
    course: c3
  )
end

3.times do |i|

  Evaluation.create!(
    tittle: "#{'Fecha' + (i.to_s)}",
    min_grade: 4,
    date: (Date.tomorrow),
    course: c1
  )

  Evaluation.create!(
  	course: c2, 
  	tittle: "#{'Fecha' + (i.to_s)}",
  	min_grade: 5,
  	date: (Date.today)
  )

  Evaluation.create!(
  	course: c3, 
  	tittle: "#{'Fecha' + (i.to_s)}",
  	min_grade: 6,
  	date: (Date.today)
  )

end

c1.evaluations.each do |evaluation| 
  evaluation.grades.each do |g|
  g.grade=rand(-1..10)
  g.save
  end
end


c3.evaluations.each do |evaluation| 
  evaluation.grades.each do |g|
    g.grade=rand(-1..10)
    g.save
  end
end
