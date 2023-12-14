# 条件式がtrueなので、breakを呼ばない限り終わらない

while true
  puts "Do you like Choco-pai?"
  answer = gets.chomp

  # 「yes」と答えない限り、繰り返しを続ける
  if answer == "yes"
    break
  end
end
