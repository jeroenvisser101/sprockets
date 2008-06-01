require File.join(File.dirname(__FILE__), *%w".. lib sprockets")
require "test/unit"

class Test::Unit::TestCase
  FIXTURES_PATH = File.expand_path(File.join(File.dirname(__FILE__), "fixtures")) unless defined?(FIXTURES_PATH)
  
  protected
    def location_for_fixture(fixture)
      File.join(FIXTURES_PATH, fixture)
    end
    
    def content_of_fixture(fixture)
      IO.read(location_for_fixture(fixture))
    end
  
    def environment_for_fixtures
      Sprockets::Environment.new(FIXTURES_PATH, source_directories_in_fixtures_path)
    end
  
    def source_directories_in_fixtures_path
      Dir[File.join(FIXTURES_PATH, "**", "src")]
    end

    def assert_absolute_location(location, pathname)
      assert_equal location, pathname.absolute_location
    end
    
    def assert_absolute_location_ends_with(location_ending, pathname)
      assert pathname.absolute_location[/#{Regexp.escape(location_ending)}$/]
    end

    def pathname(location, environment = @environment)
      Sprockets::Pathname.new(environment, File.join(FIXTURES_PATH, location))
    end
    
    def source_file(location, environment = @environment)
      Sprockets::SourceFile.new(environment, pathname(location, environment))
    end

    def source_line(line, source_file = nil, line_number = 1)
      Sprockets::SourceLine.new(source_file, line, line_number)
    end
end