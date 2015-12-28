class AddLinkPreviewToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :link_description, :text
    add_column :notes, :link_picture, :text
    add_column :notes, :link_title, :string
  end
end
