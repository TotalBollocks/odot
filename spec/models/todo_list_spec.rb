require 'spec_helper'

describe TodoList do
  it { should have_many(:todo_items) }
  
  describe "#has_completed_items?" do
    let(:list) { TodoList.create title: "Miiilky", description: "........ok" }
    
    it "is true when has completed items" do
      list.todo_items.create content: "Soy", completed_at: 1.minute.ago
      expect(list).to have_completed_items
    end
    
    it "is false when has no completed items" do
      list.todo_items.create content: "Soy", completed_at: nil
      expect(list).to_not have_completed_items
    end
  end
  
  describe "#has_incompleted_items?" do
    let(:list) { TodoList.create title: "Miiilky", description: "........ok" }
    
    it "is false when has completed items" do
      list.todo_items.create content: "Soy", completed_at: 1.minute.ago
      expect(list).to_not have_incompleted_items
    end
    
    it "is true when has no completed items" do
      list.todo_items.create content: "Soy", completed_at: nil
      expect(list).to have_incompleted_items
    end
  end
end
