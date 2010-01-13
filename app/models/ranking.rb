class Ranking < ActiveRecord::Base
#OVERVIEW: The Ranking model describes the relationship between a ranking and a picture and that between a
# ranking and a user. A ranking belongs to exactly one picture and exactly one user. Rankings are used to
# determine the winner of a contest.
# AF(c) = 
# RI = 
  belongs_to :picture
  belongs_to :user
end
