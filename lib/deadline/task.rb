require 'yaml'
require 'active_support/core_ext'
require 'terminal-notifier'

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
      puts "New task: #{new_task[:task]}, #{new_task[:deadline]}"
    end

    def self.remove(target)
      tasks = Task.all
      return unless tasks

      if target == "all"
        save_config({tasks: []})
      else
        number = target.to_i
        if number < tasks.size
          tasks.delete_at(number)
          conf = {
            tasks: tasks
          }
          save_config(conf)
        end
      end
    end

    def self.refresh
      tasks = Task.all
      tasks.sort!{ |a, b| a[:deadline] <=> b [:deadline] }

      new_tasks = Array.new
      tasks.each do |task|
        if task[:deadline] - Time.now > 0
          new_tasks.push(task)
        else
          push_notify(task)
        end
      end

      save_config({tasks: new_tasks})
    end

    def self.push_notify(task)
      TerminalNotifier.notify(
        nil,
        title: 'Deadline end',
        subtitle: task[:task]
      )
    end

    def self.print_tasks
      Task.refresh
      tasks = Task.all
      if tasks == nil || tasks.size == 0
        puts "No task available"
        return
      end
      tasks.each_with_index do |task, idx|
        puts "Task #{idx}: #{task[:task]}, #{task[:deadline]}"
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
      when /^[0-9]+$/
        Time.now + string.to_i * 60
      when /^(([0-9]|)[0-9]):([0-9][0-9])$/
        today_time = Time.local(
          Date.today.year,
          Date.today.month,
          Date.today.day,
          $1,
          $3,
          0
        )
        if today_time - Time.now >= 0
          today_time
        else
          tomorrow_time = Time.local(
            Date.tomorrow.year,
            Date.tomorrow.month,
            Date.tomorrow.day,
            $1,
            $3,
            0
          )
        end
      else
        nil
      end
    end
  end
end
