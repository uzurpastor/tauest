class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.integer :test_id
      t.string :name
    end
    add_foreign_key :questions, :tests, on_delete: :cascade
  end
end
