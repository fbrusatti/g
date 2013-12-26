class AddRawContractToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :raw_contract, :text
  end
end
