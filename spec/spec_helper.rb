$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib', 'ti'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'ti'
require 'stringio'

RSpec.configure do |config|

  def capture_with_status(stream)
    exit_status = 0
    begin
      stream = stream.to_s
      eval "$#{stream} = StringIO.new"
      begin
        yield
      rescue SystemExit => system_exit # catch any exit calls
        exit_status = system_exit.status
      end
      result = eval("$#{stream}").string
    ensure
      eval("$#{stream} = #{stream.upcase}")
    end
    return result, exit_status
  end

  def remove_directories(*names)
    project_dir = Pathname.new(Dir.pwd)
    names.each do |name|
      FileUtils.rm_rf(project_dir.join(name)) if FileTest.exists?(project_dir.join(name))
    end
  end
end
