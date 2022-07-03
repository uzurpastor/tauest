class CreatePassedTests < ActiveRecord::Migration[7.0]
  def change
    create_table :passed_tests do |t|
      t.integer :user_id
      t.integer :test_id
      t.integer :pass

      t.timestamps
    end
    add_foreign_key :passed_tests, :users, on_delete: :cascade
    add_foreign_key :passed_tests, :tests, on_delete: :cascade
  end

end
