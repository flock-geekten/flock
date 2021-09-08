class CreateHangouts < ActiveRecord::Migration[6.1]
  def change
    create_table :hangouts do |t|
      t.string :name
      t.integer :indoor
      t.integer :outdoor
      t.integer :summer
      t.integer :winter
      t.integer :house
      t.integer :town
      t.integer :mountain
      t.integer :online
      t.integer :offline
      t.integer :to_2000yen
      t.integer :to_4000yen
      t.integer :to_6000yen
      t.integer :to_8000yen
      t.integer :to_10000yen
      t.integer :over_10000yen
      t.timestamps
    end
  end
end
