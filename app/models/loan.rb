class Loan < ActiveRecord::Base
  has_many :payments, dependent: :destroy
  # since it is outside the scope of the assignment, 
  # not adding any validations for Loan - normally, one should

  def outstanding_balance
    funded_amount - payments.sum(:amount)
  end
end
