class AssociatePictureWithContest < ActiveRecord::Migration
  def self.up
  	add_column :pictures, :contest_id, :integer
  end

  def self.down
  	remove_column :pictures, :contest_id
  end
end
