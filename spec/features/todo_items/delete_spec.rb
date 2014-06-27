require 'spec_helper'

describe  "Adding todo items" do
  let!(:list) { TodoList.create  title: "Groceries", description: "desc...." }
  let!(:item) { list.todo_items.create content: "Milk" }
  
  def visit_todo_list(todo_list)
    visit todo_lists_path
    
    within "#todo_list_#{todo_list.id}" do
      click_link "List Items"
    end
  end
  
  it "is successful" do
    visit_todo_list list
    within "#todo_item_#{item.id}" do
      click_link "Delete"
    end
    
    expect(page).to have_content "You have deleted the item"
    expect(TodoItem.count).to eq 0
  end
end