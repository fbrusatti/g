class AddPrimaryInformationToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :primary_information, :string
  end
end
