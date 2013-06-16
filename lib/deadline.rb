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
      if ARGV.size < 2
        puts "Usage: deadline remove (all|TASK_NUMBER)"
        return
      end
      Task.remove(ARGV[1])
    when "tasks"
      Task.print_tasks
    when "track"
      Timer.track
    else
      print(<<-"EOS")
      Usage:
        deadline add TASK_NAME DEADLINE
        deadline remove (all|TASK_NUMBER)
        deadline tasks
        deadline track
      EOS
    end
  end
end
