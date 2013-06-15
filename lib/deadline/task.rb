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
      return unless args[:task] && args[:deadline]

      deadline_time = string_to_time(args[:deadline])
      return unless deadline_time

      new_task = {
        task: args[:task],
        deadline: deadline_time,
      }
      conf = load_config
      if conf
        conf[:tasks].push(new_task)
      else
        conf = Hash.new
        conf[:tasks] = Array.new.push(new_task)
      end
      save_config(conf)
    end

    def self.remove(number)
      tasks = Task.all
      return unless tasks

      if number < tasks.size
        tasks.delete_at(number)
        conf = {
          tasks: tasks
        }
        save_config(conf)
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

    def self.string_to_time(string)
      case string
      when /[0-9]+/
        Time.now + string.to_i * 60
      when /(([0-9]|)[0-9]):([0-9][0-9])/
        today_time = Time.now
        today_time.hour = $1
        today_time.min = $3
        today_time.sec = 0
        if today_time - Time.now >= 0
          today_time
        else
          tomorrow_time = today_time
          tomorrow_time.day += 1
          tomorrow_time
        end
      else
        nil
      end
    end
  end
end
