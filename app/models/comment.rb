class Comment < ActiveRecord::Base
	#OVERVIEW: The Comment model describes the relationships and database associations of comment,
	# user, and picture. Namely, each comment belongs to exactly one user and exactly one picture.
	# Thus, the comment is displayed along with the picture that it belongs to, with an indication 
	# of the user that created the comment.
	# AF(c) = a comment made by c.user, with body c.body
	# RI = c.user and c.body are not null
  belongs_to :picture
  belongs_to :user
  
  
  def submitted_long_ago
  #REQUIRES:
  #MODIFIES:
  #EFFECTS:
    # determine how many minutes ago was this picture created/submitted
    minutes_ago = (Time.now - self.created_at)/60
    if ( minutes_ago > 59)
       # determine how many hours ago was this picture created/submitted
      hrs_ago = minutes_ago/60
      if (hrs_ago > 23)
         # determine how many days ago was this picture created/submitted
        value = hrs_ago/24
        units = "days"
      else
        value = hrs_ago
        units = "hours"
      end
    else
      value = minutes_ago
      units = "minutes"
    end
    units.chop! if value.round == 1
    "#{value.round} #{units}"
  end
end
