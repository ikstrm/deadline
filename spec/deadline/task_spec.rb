require 'spec_helper'

module Deadline
  describe Task do
    describe ".all" do
      describe "given no config file" do
        before do
          path = File.expand_path('~/.deadline/tasks.yml')
          if FileTest.exist?(path)
            FileUtils.rm(path)
          end
        end

        it "should return nil" do
          tasks = Task.all
          tasks.should == nil
        end
      end

      describe "when config file exists" do
        before do
          path = File.expand_path('~/.deadline/')
          if FileTest.exist?(path) == false
            FileUtils.mkdir_p(path)
          end

          File.open(File.expand_path('~/.deadline/tasks.yml'), 'w') do |f|
            f << { tasks: [{task: "test", deadline: "13:30"}] }.to_yaml
          end
        end

        it "should return array" do
          tasks = Task.all
          tasks.should be_a_kind_of Array
        end
      end
    end

    describe ".add" do
      before do
        path = File.expand_path('~/.deadline/')
        if FileTest.exist?(path) == false
          FileUtils.mkdir_p(path)
        end

        File.open(File.expand_path('~/.deadline/tasks.yml'), 'w') do |f|
          f << { tasks: [{task: "test", deadline: "13:30"}] }.to_yaml
        end
      end

      describe "given a task name and valid time" do
        it "should add a task to deadline" do
          Task.add(task: "new task", deadline: "14:00")
          array = Task.all
          array.size.should == 2
        end
      end

      describe "given invalid time" do
        it "should not add a task" do
          Task.add(task: "new task", deadline: "hoge")
          array = Task.all
          array.size.should == 1
        end
      end
    end

    describe ".remove" do
      before do
        path = File.expand_path('~/.deadline/')
        if FileTest.exist?(path) == false
          FileUtils.mkdir_p(path)
        end

        File.open(File.expand_path('~/.deadline/tasks.yml'), 'w') do |f|
          f << { tasks: [
              {task: "task1", deadline: "13:30"},
              {task: "task2", deadline: "14:30"},
            ] }.to_yaml
        end
      end

      describe "given a number within range" do
        it "should remove a specific task" do
          Task.remove("1")
          Task.all.size.should == 1
        end
      end

      describe "given a number out of range" do
        it "should do nothing" do
          Task.remove("2")
          Task.all.size.should == 2
        end
      end

      describe "given 'all'" do
        it "should remove all tasks" do
          Task.remove("all")
          Task.all.size.should == 0
        end
      end
    end

    describe ".refresh" do
      describe "given disordered tasks" do
        before do
          Task.remove("all")
          Task.add(task: "test1", deadline: "10")
          Task.add(task: "test3", deadline: "30")
          Task.add(task: "test2", deadline: "20")
        end

        it "should sort the tasks" do
          Task.refresh
          tasks = Task.all
          tasks[0][:task].should == "test1"
          tasks[1][:task].should == "test2"
          tasks[2][:task].should == "test3"
        end
      end

      describe "given an expired task" do
        before do
          Task.remove("all")

          path = File.expand_path('~/.deadline/')
          if FileTest.exist?(path) == false
            FileUtils.mkdir_p(path)
          end

          File.open(File.expand_path('~/.deadline/tasks.yml'), 'w') do |f|
            f << { tasks: [{
                  task: "test",
                  deadline: Time.local(2000,1,1,10,0,0)
                }] }.to_yaml
          end
        end

        it "should remove the task" do
          Task.refresh
          tasks = Task.all
          tasks.size.should == 0
        end

        it "should push growl notification"
      end
    end
  end
end
