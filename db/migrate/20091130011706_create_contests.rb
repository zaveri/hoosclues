class CreateContests < ActiveRecord::Migration
  def self.up
	 create_table "contests" do |t|
	 t.text  :name
	 t.integer  :week
	 t.text  :winner
	 t.datetime :date
	 
	 t.timestamp
  end
  end

  def self.down
	drop_table "contests"
  end
end
