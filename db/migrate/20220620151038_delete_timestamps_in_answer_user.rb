class DeleteTimestampsInAnswerUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :answer_users, :created_at
    remove_column :answer_users, :updated_at
  end
end
