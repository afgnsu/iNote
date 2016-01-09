class AddLinksCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :links_count, :integer, null: false, default: 0
  end
end
