class CreateAnswerOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :answer_options do |t|
      t.integer :question_id
      t.boolean :right, default: false
      t.text :name
    end
    add_foreign_key :answer_options, :questions, on_delete: :cascade
  end
end
