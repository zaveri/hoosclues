class PicturesController < ApplicationController
# The PicturesController provides methods for creating new pictures in the database, accessing that
# information, and editing that information.
  # GET /pictures
  # GET /pictures.xml
  
  #this filter applies before all of the methods listed between brackets
  before_filter :login_required, :only => [:new, :edit, :rank_up, :rank_down]
  
  def index
  #REQUIRES: 
  #EFFECTS: Enables rendering of all of the pictures in a view file.
  # @pictures = Picture.paginate :per_page => 3, :page => params[:page]
    pictures = {}
    Picture.find(:all).each do |picture|
      total = picture.rating_total
      pictures.merge!(Hash[picture => total])
    end
    sorted_array_by_total = pictures.sort {|a,b| -1*(a[1] <=> b[1])}
    @pictures = []
    sorted_array_by_total.each do |array_element|
      @pictures << Hash[array_element[0], array_element[1]]
    end
    p @pictures
  end

  # GET /pictures/1
  # GET /pictures/1.xml
  def show
  #REQUIRES: :id belongs to a picture in the database
  #EFFECTS: Enables rendering of one particular picture in a view file.
    @picture = Picture.find(params[:id])
    @comment = Comment.new
    @comment.picture = @picture

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @picture }
    end
  end

  # GET /pictures/new
  # GET /pictures/new.xml
  def new
  #REQUIRES: 
  #EFFECTS: Creates a new picture
    @picture = Picture.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @picture }
    end
  end

  # GET /pictures/1/edit
  def edit
  #REQUIRES: :id belongs to a picture in the database 
  #EFFECTS: Allows to edit one of their pictures.
    if @picture = Picture.find(params[:id])
      flash[:notice] = 'Feel free to edit you picture!'
    end
  end

  # POST /pictures
  # POST /pictures.xml
  def create
  #REQUIRES:
  #MODIFIES: The database.
  #EFFECTS: Adds the information provided by the user via 'new.'
    @picture = Picture.create( params[:picture] )
    @picture.user = current_user
    if @picture.save
      flash[:notice] = 'Picture was successfully added.'
      redirect_to pictures_path
    else
      flash[:error] = 'Picture was not added, try again!'
      redirect_to new_picture_path
    end
  end

  # PUT /pictures/1
  # PUT /pictures/1.xml
  def update
  #REQUIRES: :id belongs to a picture in the database. 
  #MODIFIES: The database
  #EFFECTS: Adds the information provided by the user via 'edit.' 
    @picture = Picture.find(params[:id])

    respond_to do |format|
      if @picture.update_attributes(params[:picture])
        flash[:notice] = 'Picture was successfully updated.'
        redirect_to pictures_path
        format.html { redirect_to(@picture) }
        format.xml  { head :ok }
      else
        redirect_to new_picture_path
        format.html { render :action => "edit" }
        format.xml  { render :xml => @picture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.xml
  def destroy
  #REQUIRES: :id belongs to a picture in the database
  #MODIFIES: The database
  #EFFECTS: Removes the picture with :id from the database.
    @picture = Picture.find(params[:id])
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to(pictures_url) }
      format.xml  { head :ok }
    end
  end
  
  def rank_up
  #REQUIRES: a picture to rank
  #MODIFIES: rating
  #EFFECTS: increments rating when a user votes up a picture
  	picture = Picture.find(params[:id])
  	picture.rate(:user => current_user, :rating => 1)
  	redirect_to :action => "index"
  end

	def rank_down
	#REQUIRES: a picture to rank
  #MODIFIES: rating
  #EFFECTS: decrements rating when a user votes down a picture
  	picture = Picture.find(params[:id])
  	picture.rate(:user => current_user, :rating => -1)
  	redirect_to :action => "index"
  end
  
  # private
  # 
  # def must_own_picture
  #   @picture ||= Picture.find(params[:id])
  #   @picture.user == current_user || ownership_violation
  # end
  # 
  # def ownership_violation
  #   respond_to do |format|
  #     flash[:notice] = 'You cannot edit or delete quotes that you do not own!'
  #     format.html do
  #       redirect_to user_path(current_user)
  #     end
  #   end
end
