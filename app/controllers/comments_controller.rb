class CommentsController < ApplicationController
  before_filter :login_required
  
   def create    
    @lot = Lot.find(params[:lot_id])
    raise Exception.new('There should be a lot associated') if @lot.nil?
    
    @comment = @lot.comments.new(params[:comment])
    @comment.user = current_user
    
    if !@comment.valid?
      flash[:error] = "Comment was empty. You need write something before pressing 'Add comment'" 
      return render(:template => 'lots/show')
    end
    if !@comment.save || !@lot.save
      flash[:error] = "Something went wrong with saving the comment"
      return render(:template => 'lots/show')
    end
#    Event.create_for(@comment)
#    @lot.update_attribute(:commented_at, @comment.updated_at)
#    current_user.update_attribute(:contributed_at, Time.now)
#    @lot.subscribers << current_user
#    QueuedEmail.create_for(@comment)
    
    flash[:notice] = "Successfully posted comment"
    redirect_to lot_url(@lot, :anchor=>'comments')
  end


end
