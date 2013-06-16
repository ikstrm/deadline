require "deadline/version"
require "deadline/timer"
require "deadline/task"

module Deadline
  def self.setup
    case ARGV[0]
    when "add"
      if ARGV.size < 3
        puts "Usage: deadline add TASK_NAME DEADLINE"
        return
      end
      Task.add(task: ARGV[1], deadline: ARGV[2])
    when "remove"
      puts "pending"
    when "tasks"
      puts "pending"
    when "track"
      puts "pending"
    else
      print(<<-"EOS")
      Usage:
        deadline add TASK_NAME DEADLINE
        deadline remove TASK_NUMBER
        deadline tasks
        deadline track
      EOS
    end
  end
end
