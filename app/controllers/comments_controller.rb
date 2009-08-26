class CommentsController < ApplicationController
  before_filter :login_required
  
   def create    
    @tree = Tree.find(params[:tree_id])
    raise Exception.new('There should be a tree associated') if @tree.nil?
    
    @comment = @tree.comments.new(params[:comment])
    @comment.user = current_user
    
    if !@comment.valid?
      flash[:error] = "Comment was empty. You need write something before pressing 'Add comment'" 
      return render(:template => 'trees/show')
    end
    if !@comment.save || !@tree.save
      flash[:error] = "Something went wrong with saving the comment"
      return render(:template => 'trees/show')
    end
#    Event.create_for(@comment)
#    @tree.update_attribute(:commented_at, @comment.updated_at)
#    current_user.update_attribute(:contributed_at, Time.now)
#    @tree.subscribers << current_user
#    QueuedEmail.create_for(@comment)
    
    flash[:notice] = "Successfully posted comment"
    redirect_to tree_url(@tree, :anchor=>'comments')
  end


end
