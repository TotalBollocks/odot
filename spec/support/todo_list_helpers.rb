module TodoListHelpers
  def visit_todo_list(todo_list)
    visit todo_lists_path

    within dom_id_for(todo_list) do
      click_link "List Items"
    end
  end
end