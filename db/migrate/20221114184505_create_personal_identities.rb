class CreatePersonalIdentities < ActiveRecord::Migration[7.0]
  def change
    create_table :personal_identities do |t|
      t.string :name
      t.string :ssn
      t.text :stracTokens

      t.timestamps
    end
  end
end
