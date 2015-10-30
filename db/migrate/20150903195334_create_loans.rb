class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      # since this is not part of the assignment, not fixing the below:
      # normally, one would enforce funded_amount to be non-null on both
      # the database level (here) and model level (Loan class)
      t.decimal :funded_amount, precision: 8, scale: 2
      t.timestamps null: false
    end
  end
end
