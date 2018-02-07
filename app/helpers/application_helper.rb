module ApplicationHelper
  
  def generate_values_for_select(grade)
    array = []
    (-1..10).each do |number|
      if number == -1
        array.push [ "Ausente", -1 ]
      elsif grade.evaluation.min_grade >= number
        10.times do |f|
        	decimal = (f / 10.to_f)
          array.push [ "#{number.to_f + decimal} (D)", number + decimal ]
        end
      else
      	if number != 10
      	  10.times do |f|
        	decimal = (f / 10.to_f)
            array.push [ "#{number.to_f + decimal} (A)", number + decimal ]
          end
        else
          array.push [ "10 (A)", 10 ]
        end
      end
    end
    array
  end


end