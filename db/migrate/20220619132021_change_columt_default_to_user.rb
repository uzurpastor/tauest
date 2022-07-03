class ChangeColumtDefaultToUser < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :is_author, false
  end
end
