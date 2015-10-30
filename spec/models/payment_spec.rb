require 'rails_helper'

RSpec.describe Payment, type: :model do
  let(:loan) { Loan.create! funded_amount: 1000 }
  let(:payment) { described_class.create! loan: loan, amount: 100 }

  describe 'associations' do
    it { is_expected.to belong_to :loan }
  end

  describe 'validations' do
    # loan
    it { is_expected.to validate_presence_of :loan }
    # amount
    it { is_expected.to validate_presence_of :amount }
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }

    describe 'amount cap validation' do
      context 'when in range' do
        let(:new_payment) { described_class.new loan: loan, amount: 100 }
        
        it 'should create payment' do
          expect(new_payment.save).to be true
        end
      end

      context 'when too high' do
        let(:new_payment) { described_class.new loan: loan, amount: 1001 }

        it 'should not create payment' do
          expect(new_payment.save).to be false
        end

        it 'should report an error' do
          new_payment.save
          expect(new_payment.errors.full_messages).to include "Amount less than or equal to #{loan.outstanding_balance}"
        end
      end
    end
  end

  describe 'created_at' do
    it 'is populated on create' do
      expect(payment.created_at).to_not be nil
    end
  end

  describe 'constness' do
    it 'should raise on attempt to update' do
      expect { payment.save }.to raise_error ActiveRecord::ReadOnlyRecord
    end
  end
end
