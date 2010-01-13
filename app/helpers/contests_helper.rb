module ContestsHelper


  def while_loop_action
  	initial_time = Time.now
  		sleep(5)
  		#declare the winner
  		#cache the 'old' contest
  		#make the 'old' contest inactive
  		#create the 'new' contest
  		#self.save
  		@hours = Time.now - initial_time
  		final_vote_count = 0
  		@winner = 'defacto'
  		@contest.pictures.each do |p|
  		  vote_count = p.rating_total
  		   if final_vote_count< vote_count
  		   final_vount_count = vote_count
  		   @winner = p.user.login
  		   end
  		 end
  		 
  		@is_active = false
  		@contest = Contest.create
  	end
  	  	
  	def winner
  		@winner
  	end
end
