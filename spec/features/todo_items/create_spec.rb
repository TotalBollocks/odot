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
  
  it "displays error when no content" do
    visit_todo_list list
    click_link "Add Item"
    fill_in "Content", with: ""
    click_button "Save"
    
    expect(page).to have_content "error"
  end
  
  it "displays error when content less than 3 character" do
    visit_todo_list list
    click_link "Add Item"
    fill_in "Content", with: "hi"
    click_button "Save"
    
    expect(page).to have_content "error"
  end
end