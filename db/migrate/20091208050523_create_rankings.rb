class CreateRankings < ActiveRecord::Migration
  def self.up
    create_table :rankings do |t|
      t.integer :value
      t.string :type
      t.integer :picture_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :rankings
  end
end
