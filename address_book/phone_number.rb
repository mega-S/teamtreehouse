class PhoneNumber
  attr_accessor :kind, :number

  def first_name
    @first_name
  end

  def last_name
    @last_name
  end
  
  def to_s
    "#{kind}: #{number}"
  end

end