class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name,  null: false
      t.string :email,  null: false
      t.string :password_digest,  null: false
      t.text :introduction
      t.string :image

      t.timestamps
      t.index :email, unique: true
    end
  end
end
