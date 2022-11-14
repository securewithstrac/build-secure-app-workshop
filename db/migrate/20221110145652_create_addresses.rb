class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :alias
      t.text :stracTokens

      t.timestamps
    end
  end
end
