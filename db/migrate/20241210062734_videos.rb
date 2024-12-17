class Videos < ActiveRecord::Migration[8.0]
  def change
    create_table :videos do |t|
      t.string :url, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
