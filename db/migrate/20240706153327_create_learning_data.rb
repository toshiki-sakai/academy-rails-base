class CreateLearningData < ActiveRecord::Migration[7.0]
  def change
    create_table :learning_data do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.string :skill, null: false
      t.integer :time, null: false
      t.string :month, null: false

      t.timestamps
    end
  end
end
