class ChangeNotesCountToLinksCount < ActiveRecord::Migration
  def change
    rename_column :categories, :notes_count, :links_count
  end
end
