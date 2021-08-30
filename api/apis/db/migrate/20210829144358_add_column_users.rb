class AddColumnUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :uid, :string, null: false
  end
end
