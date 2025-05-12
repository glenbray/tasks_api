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
end
