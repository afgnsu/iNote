class AddLinksCountToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :links_count, :integer, null: false, default: 0
  end
end
