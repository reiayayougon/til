# 西暦を平成に変換
puts "西暦を入力してください"
ad = gets.to_i
heisei = ad - 1988

if heisei > 30
 puts "新年号になります"
elsif heisei > 0
  puts "平成" + heisei.to_s + "年です"
else
 puts "平成ではありません"
end
