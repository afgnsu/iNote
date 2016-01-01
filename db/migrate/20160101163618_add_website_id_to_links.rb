class AddWebsiteIdToLinks < ActiveRecord::Migration
  def change
    add_reference :links, :website, index: true, foreign_key: true
  end
end
