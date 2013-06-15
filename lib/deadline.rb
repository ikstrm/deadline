require "deadline/version"

module Deadline
  def self.setup
    case ARGV[0]
    when "add"
      puts "pending"
    when "tasks"
      puts "pending"
    when "track"
      puts "pending"
    else
      print(<<-"EOS")
      Usage:
        deadline add TASK_NAME DEADLINE
        deadline tasks
        deadline track
      EOS
    end
  end
end
