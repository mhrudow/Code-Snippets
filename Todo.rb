class Todo < ActiveRecord::Base
  attr_accessible :completed, :content, :position, :notes, :user_id
  USER_ID={1=>"Hunter", 2=>"Andy", 3=>"Michael"}
  validates :content, :presence => true
  validates :user_id, :numericality=> { :message=> "must be selected from the drop-down list"}
  belongs_to :user
end

def change_for_checkbox(instance)
  pos=1
  Todo.all.each do |todo|
    if (todo.completed!=true) && (todo.id !=instance.id)
      pos +=1
    end
  end
  old_position=instance.position
  instance.position=pos
  instance.save
end 
