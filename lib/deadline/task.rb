require 'yaml'

module Deadline
  class Task
    CONFIG_PATH = File.expand_path('~/.deadline/tasks.yml')

    def self.all
      @tasks = load_config
    end

    def self.load_config
      path = File.expand_path('~/.deadline/')
      if FileTest.exist?(path) == false
        FileUtils.mkdir_p(path)
        return nil
      end

      if FileTest.exist?(CONFIG_PATH)
        str = nil
        File.open(CONFIG_PATH, 'r') do |f|
          str = f.read
        end
        YAML.load(str)
      else
        nil
      end
    end
  end
end
