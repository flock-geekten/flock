class CreateUserHangoutResults < ActiveRecord::Migration[6.1]
  def change
    create_table :user_hangout_results do |t|
      t.integer :user_id
      t.integer :hangout_id
      t.integer :result

      t.timestamps
    end
  end
end
