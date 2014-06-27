require 'spec_helper'

describe "Editing todo lists" do
  let(:list) { TodoList.create title: "Groceries", description: "Buy shit..." }
  
  def update_list(options={})
    options[:title] ||= "Title"
    options[:description] ||= "Description.."
    
    visit todo_lists_path
       
    within "#todo_list_#{list.id}" do
      click_link "Edit"
    end
    
    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Update Todo list"
  end
  
  it "updates todo list properly" do    
    update_list title: "New Title", description: "New Desc.", list: list

    list.reload
    expect(list.title).to eq "New Title"
    expect(list.description).to eq "New Desc."
  end
  
  it "displays error when no title" do
    update_list title: "", description: "New Desc.", list: list
    expect(page).to have_content "error"
  end
  
  it "displays error when title is less than 3" do
    update_list title: "hi", description: "New Desc.", list: list
    expect(page).to have_content "error"
  end
  
  it "displays error when no description" do
    update_list title: "New Title", description: "", list: list
    expect(page).to have_content "error"
  end
  
  it "displays error when description is less than 5 chars" do
    update_list title: "New Title", description: "1234", list: list
    expect(page).to have_content "error"
  end
end