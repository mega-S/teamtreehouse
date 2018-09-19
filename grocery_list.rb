def create_list
  print "What is the list name? "
  name = gets.chomp

  hash = { "name" => name, "items" => Array.new }
  return hash
end

def add_list_item
  print "What is the item called? "
  item_name = gets.chomp

  print "How much? "
  quantity = gets.chomp

  hash = { "name" => item_name, "quantity" => quantity }
  return hash
end

def print_list(list)
  puts "List: #{list['name']}"
  puts "-----"

  list["items"].each { |item|
    puts "Item: #{item['name']}"
    puts "Quantity: #{item['quantity']}"
  }
end


list = create_list()
list["items"].push(add_list_item())

print_list(list)