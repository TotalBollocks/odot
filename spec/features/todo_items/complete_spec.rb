require 'spec_helper'

describe "completing todo items" do
  let!(:list) { TodoList.create  title: "Groceries", description: "desc...." }
  let!(:item) { list.todo_items.create content: "Milk" }
  
  specify "can mark a single item as complete" do
    expect(item.completed_at).to be_nil
    
    visit_todo_list list
    within dom_id_for(item) do
      click_link "Mark complete"
    end
    
    item.reload
    expect(item.completed_at).to_not be_nil
  end
end