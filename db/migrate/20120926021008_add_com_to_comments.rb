class AddComToComments < ActiveRecord::Migration
  def change
    add_column :comments, :com, :string
  end
end
