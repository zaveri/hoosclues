class CommentsController < ApplicationController
  before_filter :login_required, :only => [:new, :edit, :create]
  
  

# The CommentsController provides methods for creating new comments in the database, accessing that
# information, and editing that information.

  def index
    #REQUIRES: There exists a picture in the database with the picture_id passed to this method.
    #EFFECTS: Retrieves picture with picture_id and the comments for that picture. Enables rendering of 
    # all the comments belonging to a particular picture in the comments index view file. Throws an error 
    # (which is # inappropriate for users to see) if the picture_id is invalid.
    @picture = Picture.find(params[:picture_id])
    @comments = @picture.comments
  end

  def show
    #REQUIRES: There exists a picture in the database with the picture_id passed to this method.
    #EFFECTS: Allows rendering of one particular comment.
    @picture = Picture.find(params[:picture_id])
    @comment = @picture.comments.find(params[:id])
  end

  def new
    #REQUIRES: There exists a picture in the database with the picture_id passed to this method.
    #EFFECTS: Renders the form for creating a new comment.
    @picture = Picture.find(params[:picture_id])
    @comment = @picture.comments.build
  end

  def create
    #REQUIRES: There exists a picture in the database with the picture_id passed to this method.
    #MODIFIES: The database
    #EFFECTS: Adds the information to the database inputted by a user via 'new.' If successful, redirects 
    # the browser to the picture show view. If unsuccessful, redirects to the comments new view.
    @picture = Picture.find(params[:picture_id])
    @comment = @picture.comments.build(params[:comment])
    @comment.commenter = current_user;
    if @comment.save
      redirect_to picture_url(@picture, @comment)
    else
      render :action => "new"
    end
  end

  def edit
    #REQUIRES: There exists a picture in the database with the picture_id passed to this method.
    #EFFECTS: Renders the form for editing a comment.
    @picture = Picture.find(params[:picture_id])
    @comment = @picture.comments.find(params[:id])
  end

  def update
    #REQUIRES: There exists a picture in the database with the picture_id passed to this method.
    #MODIFIES: The database.
    #EFFECTS: Adds the information to the database inputted by a user via 'edit.' If successful, redirects
    # the browser to the picture comment index view. If unsuccessful, redirects back to the comment edit view.
    @picture = Picture.find(params[:picture_id])
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      redirect_to picture_comment_url(@picture, @comment)
    else
      render :action => "edit"
    end
  end

  def destroy
    #REQUIRES: There exists a picture in the database with the picture_id passed to this method.
    #MODIFIES: The database.
    #EFFECTS: Removes the comment with :id that belongs to picture with :picture_id
    @picture = Picture.find(params[:picture_id])
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to picture_comments_path(@picture) }
      format.xml  { head :ok }
    end
  end
end
