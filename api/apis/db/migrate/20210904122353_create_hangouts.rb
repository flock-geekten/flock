class CreateHangouts < ActiveRecord::Migration[6.1]
  def change
    create_table :hangouts do |t|
      t.string :name

      t.timestamps
    end
  end
end
