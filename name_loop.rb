def get_name
  name = ""
  loop do
    print "Please, enter your name(Your name must be more than 2 characters and no contains numbers.) "
    name = gets.chomp
    if name.length > 2 && !name.index(/\d/)
      break
    else
      puts "Your name must be more than 2 characters and no contains numbers. "
    end
  end
  return name
end

name = get_name()
puts "Hi #{name}"