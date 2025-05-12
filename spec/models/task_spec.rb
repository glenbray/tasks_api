require "rails_helper"

RSpec.describe Task, type: :model do
  describe "validations" do
    it "is invalid without a title" do
      task = Task.new(title: nil)
      expect(task).not_to be_valid
      expect(task.errors[:title]).to include("can't be blank")
    end

    it "is valid with a title" do
      task = Task.new(title: "Test")
      expect(task).to be_valid
    end
  end

  describe ".incomplete" do
    let!(:incomplete_task) { Task.create!(title: "Incomplete") }
    let!(:completed_task) { Task.create!(title: "Completed", completed_at: Time.current) }

    it "returns tasks that are not completed" do
      expect(Task.incomplete).to include(incomplete_task)
    end

    it "does not return tasks that are completed" do
      expect(Task.incomplete).not_to include(completed_task)
    end
  end
end
