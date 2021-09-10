class CreatePlanComments < ActiveRecord::Migration[6.1]
  def change
    create_table :plan_comments do |t|
      t.text :body
      t.integer :plan_id
      t.integer :user_id

      t.timestamps
    end
  end
end
