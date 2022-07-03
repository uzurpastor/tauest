class ChangeAttrOnDeleteForPassedTest < ActiveRecord::Migration[7.0]
  def up
    remove_foreign_key :answer_users, column: :passed_test_id
    add_foreign_key :answer_users, :passed_tests, on_delete: :cascade
  end
  def down
    remove_foreign_key :answer_users, column: :passed_test_id
    add_foreign_key :answer_users, :passed_tests
  end
end
