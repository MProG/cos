class CreateGraphs < ActiveRecord::Migration[5.0]
  def change
    create_table :graphs do |t|
      t.string :name
      t.float :max_value
      t.float :min_value
      t.float :values, array: true, default: []

      t.integer :values_in_sec
      t.integer :size

      t.timestamps
    end
  end
end
