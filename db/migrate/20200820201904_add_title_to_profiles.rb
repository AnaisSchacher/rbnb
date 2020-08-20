class AddTitleToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :title, :string
  end
end
