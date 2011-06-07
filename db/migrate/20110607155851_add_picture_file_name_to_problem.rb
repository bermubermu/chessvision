class AddPictureFileNameToProblem < ActiveRecord::Migration
  def self.up
    add_column :problems, :picture_file_name, :string
    add_column :problems, :picture_content_type, :string
    add_column :problems, :picture_file_size, :integer
  end

  def self.down
    remove_column :problems, :picture_file_name
    remove_column :problems, :picture_content_type
    remove_column :problems, :picture_file_size
  end
end
