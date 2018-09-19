require "./contacts"
require "yaml"

class AddressBook
  attr_reader :contacts

  def initialize
    @contacts = []
    open()
  end

  def open
    if File.exist?("contacts.yml")
      @contacts = YAML.load_file("contacts.yml")
    end
  end

  def delete
    
  end

  def save
    File.open("contacts.yml", "w") do |file|
      file.write(contacts.to_yaml)
    end
  end

  def run
    loop do
      puts "-" * 50
      puts "Address Book"
      puts "a: Add Contact"
      puts "d: Delete Contact"
      puts "p: Print Address Book"
      puts "s: Search"
      puts "e: exit"
      print "Enter your choice: "
      
      input = gets.chomp.downcase
      case input
      when 'e'
        save()
        break
      when 'd'
        delete_contact
      when 'p'
        print_contact_list
      when 'a'
        add_contact
      when 's'
        print "Search: "
        search = gets.chomp
        find_by_name(search)
        find_by_phone_number(search)
        find_by_address(search)
      end
    end
  end

  def add_contact
    contact = Contact.new
    print "First name: "
    contact.first_name = gets.chomp
    print "Last name: "
    contact.last_name = gets.chomp

    loop do
      puts "Add phone number and address"
      puts "p: Add a phone number"
      puts "a: Add an address"
      puts "(Any other key is exit)"
      response = gets.chomp.downcase
        case response
        when 'p'
          phone = PhoneNumber.new
          print "Phone number kind (Home, Work, etc.): "
          phone.kind = gets.chomp
          print "Number: "
          phone.number = gets.chomp
          contact.phone_numbers.push(phone)
        when 'a'
          address = Address.new
          print "Address kind (Home, Work, etc.): "
          address.kind = gets.chomp
          print "Street 1: "
          address.street_1 = gets.chomp
          print "Street 2: "
          address.street_2 = gets.chomp
          print "City: "
          address.city = gets.chomp
          print "State: "
          address.state = gets.chomp
          print "Postal code: "
          address.postal_code = gets.chomp
          contact.addresses.push(address)
        else
          print "\n"
          break
        end
     end

    contacts.push(contact)
  end

  def print_results(search, results)
    puts search
    results.each do |contact|
      puts contact.to_s('full_name')
      contact.print_phone_numbers
      contact.print_addresses
      puts "\n"
    end
  end

  def find_by_name(name)
    results = []
    search = name.downcase
    contacts.each do |contact|
      if contact.first_name.downcase.include?(search)
        results.push(contact) unless results.include?(contact)
      end
    end
    puts "-" * 50
    print_results("Name search results (#{search})", results)
  end

  def find_by_phone_number(number)
    results = []
    search = number.gsub("-", "")
    contacts.each do |contact|
      contact.phone_numbers.each do |phone_number|
        if phone_number.number.gsub("-", "").include?(search)
          results.push(contact) unless results.include?(contact)
        end
      end
    end
    puts "-" * 50
    print_results("Phone search results (#{search})", results)
    
  end

  def find_by_address(query) 
    results = []
    search = query.downcase
    contacts.each do |contact|
      contact.addresses.each do |address|
        if address.to_s('long').downcase.include?(search)
          results.push(contact) unless results.include?(contact)
        end
      end
    end
    puts "-" * 50
    print_results("Address search results (#{search})", results)
    
  end

  def print_contact_list
    puts "Contact List: "
    puts "-" * 50
    contacts.each do |contact|
      puts contact.to_s('short')
    end
    puts "-" * 50
  end

  
  def delete_contact
    puts "Contact List: "
    puts "-" * 50
    contacts.each do |contact|
      puts contact.to_s('short')
    end
    print "Enter the first name to delete: "
    first_name_delete = gets.chomp
    print "Enter the last name to delete: "
    last_name_delete = gets.chomp
 
    contacts.each do |contact|
      if contact.first_name == first_name_delete && contact.last_name == last_name_delete
        contacts.delete(contact)
      end
    end
  end


end

address_book = AddressBook.new
address_book.run