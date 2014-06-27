require 'spec_helper'

describe "Viewing todo items" do
  let!(:list) { TodoList.create  title: "Groceries", description: "desc...." }
  
  def visit_todo_list(todo_list)
    visit todo_lists_path
    
    within "#todo_list_#{todo_list.id}" do
      click_link "List Items"
    end
  end
  
  it "displays title of todo list" do
    visit_todo_list(list)
    
    within "h1" do
      expect(page).to have_content list.title
    end
  end
  
  it "displays no items when list is empty" do
    visit_todo_list(list)
    
    expect(page.all("ul.todo_items li").size).to eq 0
  end
  
  it "displays items in todo list" do
    list.todo_items.create content: "Milk"
    list.todo_items.create content: "Carrots"
    visit_todo_list(list)
    
    expect(page.all("ul.todo_items li").size).to eq 2
    within "ul.todo_items" do
      expect(page).to have_content "Milk"
      expect(page).to have_content "Carrots"
    end
  end
end