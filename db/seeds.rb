# This file contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

User.create!({:email => "admin@gmail.com", :password => "123456", :password_confirmation => "123456" })

c1=Course.create!(name: "Ruby- Primer semestre",year:"2017")
c2=Course.create!(name: "Ruby- Segundo Semestre",year:"2017")
c3=Course.create!(name: "Ruby- Primer semestre",year:"2018")
c4=Course.create!(name: "Ruby- Segundo semestre",year:"2018")

6.times do |i|
	c1.students.create!(name:"#{i}",lastname:"Estudiante", dni:i*4000000,number:"#{i}")
end

4.times do |i|
	c3.students.create!(name:"#{i}",lastname:"Estudiante", dni:i*1000,number:"#{i*10}")
end

3.times do |i|
	c1.evaluations.create!(tittle:"Fecha #{i}",min_grade:4,date:(Date.tomorrow))
	# Las lineas de abajo fallan
	#c2.evaluations.create!(tittle:"Fecha #{i}",min_grade:5,date:(Date.today+i))
	#c3.evaluations.create!(tittle:"Fecha #{i}",min_grade:6,date:(Date.today))
end


c1.evaluations.each do |evaluation| 
	evaluation.grades.each do |g|
		g.grade=rand(-1..10)
		g.save
	end
end


=begin
  Al no crearse las evaluaciones de c3, no va a tener notas
c3.evaluations.each do |evaluation| 
	evaluation.grades.each do |g|
		g.grade=rand(-1..10)
		g.save
	end
end
=end
