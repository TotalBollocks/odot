class TodoItemsController < ApplicationController
  def index
    @todo_list = TodoList.find params[:todo_list_id]
  end
  
  def new
    @todo_list = TodoList.find params[:todo_list_id]
    @todo_item = @todo_list.todo_items.new
  end
  
  def create
    @todo_list = TodoList.find params[:todo_list_id]
    @todo_item = @todo_list.todo_items.new(item_params)
    
    if @todo_item.save
      redirect_to todo_list_todo_items_path, notice: "Added todo list item"
    else
      render 'new'
    end
  end
  
  private
  
  def item_params
    params.require(:todo_item).permit(:content)
  end
end
