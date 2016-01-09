class ChangeLinkTypeInLink < ActiveRecord::Migration
  def up
    change_column :links, :link, :text
  end
end
