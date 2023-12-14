# 1から100までの３もしくは７の倍数を出力

i = 1

while i < 100
  if i % 3 == 0
    puts i
  elsif i % 7 == 0
    puts i
  end
  i += 1
end

