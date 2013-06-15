require 'yaml'

module Deadline
  class Task
    CONFIG_PATH = File.expand_path('~/.deadline/tasks.yml')

    def self.all
      conf = load_config
      return unless conf
      conf[:tasks]
    end

    def self.add(args = {})
      return unless args[:task] && deadline[:deadline]

      conf = load_config
      if conf
      else
        conf = Hash.new
        conf[:task] = args[:task]
        conf[:deadline] = args[:deadline]
      end
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

    def self.save_config(conf)
      File.open(CONFIG_PATH, 'w') do |f|
        f << conf.to_yaml
      end
    end
  end
end
