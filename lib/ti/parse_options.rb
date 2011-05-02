class ParseOptions
  
  ##
  # Initialize
  #
  def initialize(args, &block)
    @args = args
    instance_eval(&block) if block_given?
  end
  
  
  ##
  # Help Menu
  #
  def help(value, value2='', &block)
    puts yield(block) if display_message?(value, value2)
  end
  alias_method :version, :help
  
  
  ##
  # Scan for values
  #
  def scan_for_value(v1, v2='', &block)
    found = nil
    @args.each_with_index do |value, index|
      next if found
      found = @args[index + 1] if (v1.to_s == value.to_s || v2.to_s == value.to_s)
    end
    yield found 
  end
  alias_method :value, :scan_for_value
  
  
  ##
  # Boolean
  #
  def boolean(v1, v2='', &block)
    found = false
    @args.each do |value|
      next if found
      found = true if (v1.to_s == value.to_s || v2.to_s == value.to_s)
    end
    block_given? ? yield(found) : found
  end
  alias_method :display_message?, :boolean

end