class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.string :title
      t.text :body
      t.integer :user_id
      t.integer :is_done

      t.timestamps
    end
  end
end
