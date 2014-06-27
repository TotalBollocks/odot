require "spec_helper"

describe "Deleting todo lists" do
  let!(:list) { TodoList.create title: "Groceries", description: "Buy shit..." }
  
  it "deletes list when Destroy link clicked" do
    visit todo_lists_path
    
    within "#todo_list_#{list.id}" do
      click_link "Destroy"
    end
    
    expect(TodoList.count).to eq 0
    expect(page).to_not have_content list.title
  end
end