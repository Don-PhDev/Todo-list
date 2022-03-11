class CreateTodos < ActiveRecord::Migration[6.1]
  def change
    create_table :todos do |t|
      t.string :title, null: false, index: { unique: true }
      t.boolean :is_completed

      t.timestamps
    end
  end
end
