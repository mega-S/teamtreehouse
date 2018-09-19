random_num = Random.new.rand(10)

loop do
  print "Guess the number between 0 and 10 (\"e\" to exit): "
  answer = gets.chomp.to_i
  if answer == "e"
    puts "The random number is #{random_num}"
    break
  else
    if answer == random_num
      puts "Gratz, you win!"
      break
    else
      puts "Please, try again"
    end
  end
end