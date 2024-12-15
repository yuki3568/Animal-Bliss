class AddTitleToVideos < ActiveRecord::Migration[8.0]
  def change
    add_column :videos, :title, :string, null: false
  end
end
