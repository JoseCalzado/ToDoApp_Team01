class TodoItemsController < ApplicationController
 before_action :set_todo_list
 before_action :set_todo_item, except: [:create]

  # GET /todo_lists
  # GET /todo_lists.json
  def index
    @todo_lists = TodoList.all
  end

  # GET /todo_lists/1
  # GET /todo_lists/1.json
  def show
  end

  # GET /todo_lists/new
  def new
    @todo_item = TodoItem.new
  end

  # GET /todo_lists/1/edit
  def edit
    @todo_item = TodoItem.find(params[:id])
  end

def create
 @todo_item = @todo_list.todo_items.create(todo_item_params)
 redirect_to @todo_list
end

def destroy
 @todo_item = @todo_list.todo_items.find(params[:id])
 if @todo_item.destroy
  flash[:success] = "Todo List item was deleted."
 else
  flash[:error] = "Todo List item could not be deleted."
 end
 redirect_to @todo_list 
end



def update
  @todo_item = TodoItem.find(params[:id])
  if @todo_item.completed
    @todo_item.update(completed: false)
  else
    @todo_item.update(completed: true)
  end
  redirect_to @todo_list
end

def complete
 @todo_item.update_attribute(:completed_at, Time.now)
 redirect_to @todo_list, notice: "Todo item completed"
end

def uncomplete
  @todo_item.update_attribute(:completed_at, "")
  redirect_to @todo_list, notice: "Todo item uncompleted"
 end

private

def set_todo_list
 @todo_list = TodoList.find(params[:todo_list_id])
end

def set_todo_item
 @todo_item = @todo_list.todo_items.find(params[:id])
end

def todo_item_params
 params[:todo_item].permit(:content, :priority, :deadline)
end

end