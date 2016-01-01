class ChangeNotesCountToLinksCount < ActiveRecord::Migration
  def change
    rename_column :categories, :notes_count, :links_count, null: false, default: 0
  end
end
