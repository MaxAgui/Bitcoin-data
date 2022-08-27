class CreateBitcoins < ActiveRecord::Migration[7.0]
  def change
    create_table :bitcoins do |t|
      t.string :hashb, null: false
      t.string :prev_block
      t.string :block_index
      t.string :time
      t.string :bits

      t.timestamps
    end
  end
end
