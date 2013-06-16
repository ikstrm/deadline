# -*- coding: utf-8 -*-
require 'curses'

module Deadline
  LABEL_GREEN = 1
  LABEL_RED = 2
  LABEL_WHITE = 3

  class Timer
    def self.track
      tasks = Task.all
      if tasks == nil || tasks.size == 0
        puts "No task available"
        return
      end

      Curses.init_screen
      Curses.start_color
      Curses.init_pair LABEL_GREEN, Curses::COLOR_GREEN, Curses::COLOR_BLACK
      Curses.init_pair LABEL_RED, Curses::COLOR_RED, Curses::COLOR_BLACK
      Curses.init_pair LABEL_WHITE, Curses::COLOR_WHITE, Curses::COLOR_BLACK

      loop do
        Task.refresh
        tasks = Task.all
        if tasks.size == 0
          Curses.close_screen
          break
        end

        tasks.each_with_index do |task, idx|
          last_time = ""
          line_pos = Curses.lines / 2
          if idx == 0
            last_time = special_last_time_of(task)
          else
            line_pos += idx + 2
            last_time = last_time_of(task)
          end
          task_str = "#{last_time} - #{task[:task]}"

          Curses.setpos(line_pos, Curses.cols / 2 - (task_str.length / 2))
          Curses.addstr(task_str)
        end
        Curses.attron(Curses.color_pair(LABEL_WHITE))

        top_label = "【Latest Task】"
        Curses.setpos(Curses.lines / 2 - 1, Curses.cols / 2 - (top_label.length / 2))
        Curses.addstr(top_label)

        if tasks.size > 1
          top_label = "【Other Tasks】"
          Curses.setpos(Curses.lines / 2 + 2, Curses.cols / 2 - (top_label.length / 2))
          Curses.addstr(top_label)
        end

        Curses.refresh
        sleep(1)
        Curses.close_screen
        Curses.init_screen
      end
    end

    def self.special_last_time_of(task)
      last_time = task[:deadline] - Time.now
      hour = (last_time / 3600).to_i
      min = ((last_time % 3600) / 60).to_i
      sec = (last_time % 60).to_i
      if hour > 0
        Curses.attron(Curses.color_pair(LABEL_GREEN))
        "%dhour %dmin %dsec" % [hour, min, sec]
      elsif min > 10
        Curses.attron(Curses.color_pair(LABEL_GREEN))
        "%dmin %dsec" % [min, sec]
      elsif min > 0
        Curses.attron(Curses.color_pair(LABEL_RED))
        "%dmin %dsec" % [min, sec]
      else
        Curses.attron(Curses.color_pair(LABEL_RED))
        "%dsec" % sec
      end
    end

    def self.last_time_of(task)
      last_time = task[:deadline] - Time.now
      hour = (last_time / 3600).to_i
      min = ((last_time % 3600) / 60).to_i
      sec = (last_time % 60).to_i
      Curses.attron(Curses.color_pair(LABEL_WHITE))
      "%02d:%02d:%02d" % [hour, min, sec]
    end
  end
end
