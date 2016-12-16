class Task < ActiveRecord::Base
  has_many :comments


end



  # def all_the_tasks
  #   Task.all.each |task| do
  #     task
  #     #find each task's Comments
  #     #find each Comments' contents
  #     #print it all in a list (ex => Task: Comment, Task: Comment)
  #   end
  # end
