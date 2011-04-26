module Ti
  class Logger
    
    def self.report(msg)
      $stdout.puts(msg.green.bold)
    end

    def self.error(msg)
      $stderr.puts(msg.red.bold)
    end
      
  end
end