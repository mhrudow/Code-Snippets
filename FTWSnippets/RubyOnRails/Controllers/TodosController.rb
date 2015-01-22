class TodosController < ApplicationController
  def index
    @todos= Todo.all(:order =>"position")
    @todo=Todo.new(params[:todo])
  end 
  
  def new
    @todo = Todo.new
  end

  
  def update
    @todo = Todo.find(params[:id])
    old_pos=@todo.position
    old_checkbox=@todo.completed
    respond_to do |format|
      if @todo.update_attributes(params[:todo])
        format.html { redirect_to(@todo, :notice => 'Todo was successfully updated.') }
        format.json { respond_with_bip(@todo) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@todo) }
      end
    end
    if @todo.completed==old_checkbox
      1==1
    else
      change_for_checkbox(@todo)
    end
    if @todo.position < 1
      switch_position(@todo, old_pos)
      @todo.position=1
      @todo.save
    elsif @todo.position > last_position
      switch_position(@todo, old_pos)
      @todo.position=last_position
      @todo.save
    else
      switch_position(@todo, old_pos)
    end
  end
