require 'spec_helper'

describe  "Adding todo items" do
  let!(:list) { TodoList.create  title: "Groceries", description: "desc...." }
  
  def visit_todo_list(todo_list)
    visit todo_lists_path
    
    within "#todo_list_#{todo_list.id}" do
      click_link "List Items"
    end
  end  
  
  it "is successful with valid content" do
    visit_todo_list(list)
    click_link "Add Item"
    fill_in "Content", with: "Milk"
    click_button "Save"
    
    expect(page).to have_content "Added todo list item"
    within "ul.todo_items" do
      expect(page).to have_content "Milk"
    end
  end
end