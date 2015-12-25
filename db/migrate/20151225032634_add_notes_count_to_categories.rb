class AddNotesCountToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :notes_count, :integer, null: false, default: 0
  end
end
