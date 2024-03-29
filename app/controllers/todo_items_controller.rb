class TodoItemsController < ApplicationController
  before_action :find_list
  def index
  end
  
  def new
    @todo_item = @todo_list.todo_items.new
  end
  
  def create
    @todo_item = @todo_list.todo_items.new(item_params)
    
    if @todo_item.save
      redirect_to todo_list_todo_items_path(@todo_list), notice: "Added todo list item"
    else
      render 'new'
    end
  end
  
  def edit
    @todo_item = @todo_list.todo_items.find(params[:id])
  end
  
  def update
    @todo_item = @todo_list.todo_items.find(params[:id])
    
    if @todo_item.update(item_params)
      redirect_to todo_list_todo_items_path(@todo_list), notice: "Saved todo item"
    else
      render 'new'
    end
  end
  
  def destroy
    @todo_item = @todo_list.todo_items.find(params[:id])
    if @todo_item.destroy
      flash[:success] = "You have deleted the item"
    else
      flash[:alert] = "Item not deleted"
    end
    redirect_to [@todo_list, @todo_item]
  end
  
  def complete
    @todo_item = @todo_list.todo_items.find(params[:id])
    @todo_item.update completed_at: Time.now
    redirect_to todo_list_todo_items_path(@todo_list), notice: "Item was marked as complete"
  end
  
  private
  
  def item_params
    params.require(:todo_item).permit(:content)
  end
  
  def find_list
    @todo_list = TodoList.find params[:todo_list_id]
  end
end
