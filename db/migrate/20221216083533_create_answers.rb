class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.text :body, null: false
      t.references :question, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
