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
      describe "given a task name and valid time" do
        before do
          path = File.expand_path('~/.deadline/')
          if FileTest.exist?(path) == false
            FileUtils.mkdir_p(path)
          end

          File.open(File.expand_path('~/.deadline/tasks.yml'), 'w') do |f|
            f << { tasks: [{task: "test", deadline: "13:30"}] }.to_yaml
          end
        end

        it "should add a task to deadline" do
          Task.add(task: "new task", deadline: "14:00")
          array = Task.all
          array.size.should == 2
        end
      end

      describe "given invalid time" do
        it "should not add a task" do
          ;
        end
      end
    end

    describe ".remove" do
      it "" do
        ;
      end
    end
  end
end
