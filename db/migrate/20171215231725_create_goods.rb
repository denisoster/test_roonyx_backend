class CreateGoods < ActiveRecord::Migration[5.1]
  def change
    create_table :goods do |t|
      t.string :title, null: false, default: ""

      t.timestamps
    end
  end
end
