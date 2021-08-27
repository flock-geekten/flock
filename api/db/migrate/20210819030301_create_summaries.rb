class CreateSummaries < ActiveRecord::Migration[6.1]
  def change
    create_table :summaries do |t|
      t.text :content
      t.integer :post_id

      t.timestamps
    end
  end
end
