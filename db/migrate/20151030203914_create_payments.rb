class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.belongs_to :loan, null: false
      t.decimal :amount, precision: 8, scale: 2, null: false
      # no need for updated_at because the record is readonly:
      t.datetime :created_at, null: false

      t.index :loan_id
    end
  end
end
