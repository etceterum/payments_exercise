require 'rails_helper'

# Note: only creating tests for new functionality added
# while working on this assignment;
# Please refer to README.md clause on hidden objective
# for the explanation
RSpec.describe Loan, type: :model do
  let(:loan) { Fabricate(:loan, funded_amount: 10000) }

  describe 'associations' do
    it { is_expected.to have_many(:payments).dependent(:destroy) }
  end

  describe '#outstanding_balance' do
    before do
      3.times do |i|
        Fabricate(:payment, loan: loan, amount: (i + 1)*100)
      end
    end

    it 'should return the difference between funded_amount and sum of all payment amounts' do
      expect(loan.outstanding_balance).to eq(loan.funded_amount - 600)
    end
  end
end
