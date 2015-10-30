class Payment < ActiveRecord::Base
  belongs_to :loan

  validates :loan, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate  :check_amount_cap, on: :create
  # not validating created_at because it will be generated during
  # the insertion in the database; and if something goes wrong there,
  # we'll get an exception because the column is created with non-null option

  # once created, payments should not be altered:
  def readonly?
    !new_record?
  end

  private

  # checks that the amount of the payment is in range - i.e. that when 
  # this payment is applied, the outstanding balance of the loan
  # is not exceeded
  def check_amount_cap
    # loan association presence is checked elsewhere
    return unless loan
    # caching outstanding balance in a variable to avoid multiple calls:
    outstanding_balance = loan.outstanding_balance
    if amount.to_f > outstanding_balance
      errors.add :amount, "less than or equal to #{outstanding_balance}"
    end
  end
end
