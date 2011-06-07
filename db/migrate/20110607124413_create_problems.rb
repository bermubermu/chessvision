class CreateProblems < ActiveRecord::Migration
  def self.up
    create_table :problems do |t|
      t.string :name
      t.string :question
      t.string :picture

      t.timestamps
    end
  end

  def self.down
    drop_table :problems
  end
end
