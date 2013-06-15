module Deadline
  class Task
    def initialize
      @tasks = Hash.new
    end

    def self.all
      @tasks
    end
  end
end
