puts "生まれた年を西暦で入力ください"
birth_year = gets.chomp
age = 2023 - birth_year.to_i
puts "あなたは今年" + age.to_s + "才です"
