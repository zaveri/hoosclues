class Picture < ActiveRecord::Base
#OVERVIEW: The Picture model describes the relationship between a picture and a user, which is that each 
# picture belongs to exactly one user. It also describes the relationship with a comment; Each picture
# has many comments. The model also has methods submitted_long_ago, which determines how long ago the
# picture was submitted, which is important for ordering the pictures when they are displayed. 
# AF(c) = c.Image with associated user, title, and time stamp
# Rep = Image file is not null, user is a valid user, title is not null, time is a valid time 



  belongs_to :user
  belongs_to :contest
  has_many :comments
  
  
  #paperclip plugin by thoughbot
  has_attached_file :image, :styles => {:thumb => ["240x224#", :png], :medium => ["500x500>", :png], :large => ["1000x1000>", :png]  }
  
  # # pagination
  # Picture.paginate :page => 1
  
  has_ratings
  
  validates_presence_of :title


def getUser
  @picture.user.login
end

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

