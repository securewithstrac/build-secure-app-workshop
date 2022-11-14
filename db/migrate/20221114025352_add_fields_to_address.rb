class AddFieldsToAddress < ActiveRecord::Migration[7.0]
  def change
    add_column :addresses, :line1, :string
    add_column :addresses, :line2, :string
    add_column :addresses, :city, :string
    add_column :addresses, :state, :string
    add_column :addresses, :zipCode, :string
  end
end
