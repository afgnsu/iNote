class CreateWebsites < ActiveRecord::Migration
  def change
    create_table :websites do |t|
      t.string :host
      t.string :scheme
      t.string :title
      t.integer :count, null: false, default: 0

      t.timestamps null: false
    end
    
    add_index :websites, :host
  end
end
