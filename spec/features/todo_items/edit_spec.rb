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
  
  it "successful with valid content" do
    visit_todo_list list
    within "#todo_item_#{item.id}" do
      click_link "Edit"
    end
    fill_in "Content", with: "Lots of milk.."
    click_button "Save"
    
    expect(page).to have_content "Saved todo item"
    item.reload
    expect(item.content).to eq "Lots of milk.."
  end
  
  it "unsuccessful with invalid content" do
    visit_todo_list list
    within "#todo_item_#{item.id}" do
      click_link "Edit"
    end
    fill_in "Content", with: ""
    click_button "Save"
    
    expect(page).to have_content "error"
    item.reload
    expect(item.content).to eq "Milk"
  end
  
  it "unsuccessful with too short content" do
    visit_todo_list list
    within "#todo_item_#{item.id}" do
      click_link "Edit"
    end
    fill_in "Content", with: "12"
    click_button "Save"
    
    expect(page).to have_content "error"
    item.reload
    expect(item.content).to eq "Milk"
  end
end