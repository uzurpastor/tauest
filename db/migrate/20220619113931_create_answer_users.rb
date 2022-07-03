class CreateAnswerUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :answer_users do |t|
      t.integer :answer_option_id
      t.integer :user_id
      t.string :answer
      t.boolean :right

      t.timestamps
    end
    add_foreign_key :answer_users, :answer_options, on_delete: :cascade
    add_foreign_key :answer_users, :users, on_delete: :cascade
  end
end
