age = 25
gender = "female"

if age >= 20 && age < 35 && gender == "female"
  puts "F1層です"
end

# 以下は上と同じ
if age >= 20
  if age < 35
    if gender == "female"
      puts "F1層です"
    end
  end
end


