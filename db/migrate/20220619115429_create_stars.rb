class CreateStars < ActiveRecord::Migration[7.0]
  def change
    create_table :stars do |t|
      t.integer :user_id
      t.integer :test_id
    end
    add_foreign_key :stars, :users
    add_foreign_key :stars, :tests, on_delete: :cascade
  end
end
