class EmbedPassedTest < ActiveRecord::Migration[7.0]
  def up
    remove_foreign_key :answer_users, column: :user_id
    remove_column :answer_users, :user_id

    add_column :answer_users, :passed_test_id, :integer
    add_foreign_key :answer_users, :passed_tests
  end

  def down
    remove_foreign_key :passed_tests, column: :user_id
    remove_foreign_key :answer_users, column: :passed_test_id
    remove_column :answer_users, :passed_test_id

    add_column :answer_users, :user_id, :integer
    add_foreign_key :answer_users, :users
  end
end
