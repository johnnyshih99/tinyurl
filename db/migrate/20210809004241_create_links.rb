class CreateLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :links do |t|
      t.string :url
      t.string :token

      t.timestamps
    end
    add_index :links, :url
    add_index :links, :token
  end
end
