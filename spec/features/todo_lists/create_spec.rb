require 'spec_helper'

describe  "Creating todo lists" do
  
  def create_list(options={})
    options[:title] ||= "My todo list"
    options[:description] ||= "The description"
    
    visit todo_lists_path
    click_link "New Todo list"
    expect(page).to have_content "New todo_list"
    
    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Create Todo list"
  end
  
  it "redirects to todo list index page on success" do
    
    create_list
    
    expect(page).to have_content "My todo list"
  end
  
  it "displays error when no title" do
    expect(TodoList.count).to eq 0
    
    create_list title: ""
    
    expect(TodoList.count).to eq 0
    expect(page).to have_content "error"
  end
  
  it "displays error when title has less than 3 characters" do
    expect(TodoList.count).to eq 0
    
    create_list title: "12"
    
    expect(TodoList.count).to eq 0
    expect(page).to have_content "error"
  end
  
  it "displays error when description is blank" do
    expect(TodoList.count).to eq 0
    
    create_list description: ""
    
    expect(TodoList.count).to eq 0
    expect(page).to have_content "error"
  end
  
  it "displays error when description is less than 5 characters" do
    expect(TodoList.count).to eq 0
    
    create_list description: "1234"
    
    expect(TodoList.count).to eq 0
    expect(page).to have_content "error"
  end
end