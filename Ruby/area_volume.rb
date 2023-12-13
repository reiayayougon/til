# 幅をx, 高さをy, 奥行きをzとする

x = 10   #幅
y = 20   #高さ
z = 30   #奥行き

area = (x*y + y*z + z*x) * 2
volume = x * y * z

puts "表面積 ": + area.to_s
puts "体積 : " + volume.to_s
