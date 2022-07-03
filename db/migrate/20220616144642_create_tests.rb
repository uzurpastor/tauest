class CreateTests < ActiveRecord::Migration[7.0]
  def change
    create_table :tests do |t|
      t.integer :user_id
      t.text :name

      t.timestamps
    end
    add_foreign_key :tests, :users, on_delete: :cascade
  end
end
