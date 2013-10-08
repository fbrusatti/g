class CreateMoney < ActiveRecord::Migration
  def change
    create_table :money do |t|
      t.string :name
      t.string :symbol, default: "$"
      t.decimal :quotation, precision: 8, scale: 2
      t.references :p_rent, index: true
      t.references :p_sale, index: true
      t.timestamps
    end
  end
end
