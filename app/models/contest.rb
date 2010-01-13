class Contest < ActiveRecord::Base
#OVERVIEW: The Contest model describes the relationship between a contest and its pictures, namely, that
# contest has many pictures. Furthermore, pictures are listed in descending order when displayed.
#AF(c) = a contest based on finding pictures that represent c.name, which takes place one the <c.week>th
# week after the launch of the app. The winner of the contest is a user c.winner
#RI = c.name and c.word and c.winner are not null


has_many :pictures, :order => "created_at DESC"

#variables that belong to a contest
attr_accessible :is_active, :hours, :count_time, :key_words, :week, 
	:index

#initialization of :index
index=0

# array of words that can be used in a contest
key_words = ['First Year', 'Second Year', 'Cramming', 'Donezo', 'Ballin',
	'Mr. Jefferson', 'Lawnie', 'Comm School', 'Cav Man', 'Streaking', 'Winter',
	'Bro', 'Incompatible', 'Too Much Facebook']

end
