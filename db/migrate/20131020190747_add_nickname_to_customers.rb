class AddNicknameToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :nickname, :string
  end
end
