class BankAccount
  attr_reader :name
  def initialize(name)
    @name = name
    @transactions = []
    add_transaction("Beginning balance", 0)
  end

  def credit(description, amount)
    add_transaction(description, amount)
  end

  def debit(description, amount)
    add_transaction(description, -amount)
  end

  def add_transaction(description, amount)
    @transactions.push(description: description, amount: amount)
  end

  def balance
    balance = 0
    @transactions.each do |transaction|
      balance += transaction[:amount]
    end
    return balance
  end

  def to_s
    return "Name: #{name}, Balance: #{sprintf("%0.2f", balance)}"
  end

  def print_register
    puts "#{name}'s Bank Account"
    puts "-" * 40

    puts "Description".ljust(30) + "Transaction".rjust(10)
    @transactions.each do |transaction|
      puts transaction[:description].ljust(30) + "------>" + sprintf(sprintf("%0.2f",transaction[:amount]).rjust(10))
    end

    puts "Balance: #{sprintf("%0.2f", balance)}"
  end

end

bank_account = BankAccount.new("Valentin")
bank_account.credit("Groceries", 200)
bank_account.debit("Gold", 100)
bank_account.debit("Gold", 20)
puts bank_account.print_register
