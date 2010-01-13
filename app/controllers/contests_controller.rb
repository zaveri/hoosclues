class ContestsController < ApplicationController
#OVERVIEW: The ContestsController provides methods for creating new contests in the database, accessing that
# information, and editing that information.


  # GET /contests
  # GET /contests.xml

  def contest_action
  #MODIFIES: this, contest db
  #REQUIRES: this be parameterized
  #EFFECTS: iterates thrugh the list of words to simulate the changig of the 
  	#contest theme every week.  The new theme and winner are updated  to the db.
  	#WARNING, Deprecated, not safe to run the thread whie server if running

  		Thread.new {

  	while (@index < 14) do

  		@contest.update_attribute(:name,contest_theme)
  		#sleep(604800)
  		final_vote_count = 0
  		@contest.update_attribute(:winner,'defacto')
  		 @contest.pictures.each do |p|
  		  vote_count = p.rating_total
  		   if final_vote_count< vote_count
  		   final_vount_count = vote_count
  		   winner = p.user.login
  			end
		end
		@index += 1
		@contest.update_attribute(:is_active, 'false')
		
   		end
   		}
  end
  
  	  	
  	def contest_theme
  	#EFFECTS: Returns the current contest theme for the interator
  		@key_words[@index]
  	end
	
  def index
  #EFFECTS: Allows rendering of all contests in descending order by week.
    @contests = Contest.all(:order => "week DESC")
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contests }
    end
  end

  # GET /contests/1
  # GET /contests/1.xml
  def show
  #REQUIRES: existence of contest with :id
  #EFFECTS: allows rendering of one particular contest and its properties
    @contest = Contest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contest }
    end
  end

  # GET /contests/new
  # GET /contests/new.xml
  def new
  #EFFECTS: Allows rendering of a form for inputting information to create a new contest.
    @contest = Contest.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contest }
    end
  end

  # GET /contests/1/edit
  def edit
  #REQUIRES: existence of contest with :id
  #EFFECTS: Allows rendering of a form for inputting information to edit an existing contest.
    @contest = Contest.find(params[:id])
  end

  # POST /contests
  # POST /contests.xml
  def create
  #MODIFIES: the database
  #EFFECTS: updates the database with information about contest with :id provided by the user
  # in the form rendered by the 'new' method
    @contest = Contest.new(params[:contest])
    
    @index =0
 	@key_words = ['First Year', 'Second Year', 'Cramming', 'Donezo', 'Ballin',
 	'Mr. Jefferson', 'Lawnie', 'Comm School', 'Cav Man', 'Streaking', 'Winter',
 	'Bro', 'Incompatible', 'Too Much Facebook']
# 
#     #NEW CODE ADDED TO SCAFFOLDED METHOD
#      @is_active = 'true'
# 	  @hours = 0
#  	  @name=key_words[index]
#  	  @index++ 	  
#     #END OF NEW CODE
#   
    
    respond_to do |format|
      if @contest.save
        flash[:notice] = 'Contest was successfully created.'
        format.html { redirect_to(@contest) }
        format.xml  { render :xml => @contest, :status => :created, :location => @contest }

      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contest.errors, :status => :unprocessable_entity }
      end
  	end
  	  
  end
  
  

  # PUT /contests/1
  # PUT /contests/1.xml
  def update
  #REQUIRES: existence of contest with :id
  #MODIFIES: the database
  #EFFECTS: updates the database with info about contest with "id provided by user via 'edit.'
    @contest = Contest.find(params[:id])

    respond_to do |format|
      if @contest.update_attributes(params[:contest])
        flash[:notice] = 'Contest was successfully updated.'
        format.html { redirect_to(@contest) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contest.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contests/1
  # DELETE /contests/1.xml
  def destroy
  #REQUIRES: existence of contest with :id
  #MODIFIES: the database
  #EFFECTS: deletes the information in the database of the contest with :id
    @contest = Contest.find(params[:id])
    @contest.destroy

    respond_to do |format|
      format.html { redirect_to(contests_url) }
      format.xml  { head :ok }
    end
  end
  
end
