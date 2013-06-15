require 'spec_helper'

module Deadline
  describe Task do
    describe ".all" do
      it "should return hash" do
        tasks = Task.all
        tasks.should be_a_kind_of Hash
      end
    end

    describe ".add" do
      describe "given a task name and valid time" do
        it "should add a task to deadline" do
          ;
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
