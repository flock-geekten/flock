class CreateHangouts < ActiveRecord::Migration[6.1]
  def change
    create_table :hangouts do |t|
      t.string :name
      t.integer :easy_week
      t.integer :small_group
      t.integer :large_group
      t.integer :indoor
      t.integer :outdoor
      t.integer :summer
      t.integer :winter
      t.integer :house
      t.integer :town
      t.integer :mountain
      t.integer :sea
      t.integer :nonbiri
      t.integer :waiwai
      t.integer :scream
      t.integer :dont_move
      t.integer :move
      t.integer :exercise
      t.integer :online
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
