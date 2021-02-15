class CreateTexts < ActiveRecord::Migration[6.0]
  def change
    create_table :texts do |t|
      t.text :description
      t.text :readability_index
      t.float :flesh_index
      t.float :speed_index
      t.references :reader, null: false, foreign_key: true

      t.timestamps
    end
  end
end
