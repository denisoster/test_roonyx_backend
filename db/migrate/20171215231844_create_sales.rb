class CreateSales < ActiveRecord::Migration[5.1]
  def change
    create_table :sales do |t|
      t.date :date, null: false, default: ""
      t.float :income, null: false, default: 0
      t.references :good, index: true, foreign_key: true

      t.timestamps
    end
  end
end
