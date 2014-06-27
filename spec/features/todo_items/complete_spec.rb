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
  
  context "completed items" do
    let!(:completed_item) { list.todo_items.create content: "Eggs", completed_at: 5.minutes.ago }
    
    specify "shown as complete" do
      visit_todo_list list
      within dom_id_for(completed_item) do
        expect(page).to have_content completed_item.completed_at
      end
    end
    
    specify "cannot mark as complete again" do
      visit_todo_list list
      within dom_id_for(completed_item) do
        expect(page).to_not have_content "Mark complete"
      end      
    end
  end
end