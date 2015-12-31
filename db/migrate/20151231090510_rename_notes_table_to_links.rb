class RenameNotesTableToLinks < ActiveRecord::Migration
  def change
    rename_table :notes, :links
  end
end
