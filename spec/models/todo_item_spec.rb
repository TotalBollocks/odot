require 'spec_helper'

describe TodoItem do
  it { should belong_to :todo_list }
  
  describe "#completed?" do
    let(:item) { TodoItem.create content: "Miiilk" }
    
    it "is false when completed_at is nil" do
      item.completed_at = nil
      expect(item).to_not be_completed
    end
    
    it "is true when completed_at has a time" do
      item.completed_at = Time.now
      expect(item).to be_completed
    end
  end
end
