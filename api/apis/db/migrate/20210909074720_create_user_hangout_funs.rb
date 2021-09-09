class CreateUserHangoutFuns < ActiveRecord::Migration[6.1]
  def change
    create_table :user_hangout_funs do |t|
      t.integer :user_id
      t.integer :hangout_id
      t.integer :fun_score

      t.timestamps
    end
  end
end
