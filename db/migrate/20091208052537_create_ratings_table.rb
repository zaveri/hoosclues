class CreateRatingsTable < ActiveRecord::Migration
  def self.up
  	create_table :ratings do |t|
      t.integer :rating, :default => 0, :null => false
      t.references :rateable, :polymorphic => true
      t.references :user
      t.timestamps
    end
    
    add_index :ratings, :rateable_type
    add_index :ratings, :rateable_id
    add_index :ratings, :user_id
  end

  def self.down
  	drop_table :ratings
  end
end
