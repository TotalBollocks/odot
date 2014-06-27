require 'spec_helper'

describe  "Creating todo lists" do
  it "redirects to todo list index page on success" do
    visit todo_lists_path
    click_link "New Todo list"
    expect(page).to have_content "New todo_list"
    
    fill_in "Title", with: "My todo list"
    fill_in "Description", with: "This is stuff"
    click_button "Create Todo list"
    
    expect(page).to have_content "My todo list"
  end
  
  it "displays error when no title" do
    expect(TodoList.count).to eq 0
    
    visit todo_lists_path
    click_link "New Todo list"
    
    fill_in "Title", with: ""
    fill_in "Description", with: "This is stuff"
    click_button "Create Todo list"
    
    expect(TodoList.count).to eq 0
    expect(page).to have_content "error"
  end
  
  it "displays error when title has less than 3 characters" do
    expect(TodoList.count).to eq 0
    
    visit todo_lists_path
    click_link "New Todo list"
    
    fill_in "Title", with: "Hi"
    fill_in "Description", with: "This is stuff"
    click_button "Create Todo list"
    
    expect(TodoList.count).to eq 0
    expect(page).to have_content "error"
  end
  
  it "displays error when description is blank" do
    expect(TodoList.count).to eq 0
    
    visit todo_lists_path
    click_link "New Todo list"
    
    fill_in "Title", with: "Groceries"
    fill_in "Description", with: ""
    click_button "Create Todo list"
    
    expect(TodoList.count).to eq 0
    expect(page).to have_content "error"
  end
  
  it "displays error when description is less than 5 characters" do
    expect(TodoList.count).to eq 0
    
    visit todo_lists_path
    click_link "New Todo list"
    
    fill_in "Title", with: "Groceries"
    fill_in "Description", with: "almo"
    click_button "Create Todo list"
    
    expect(TodoList.count).to eq 0
    expect(page).to have_content "error"
  end
end