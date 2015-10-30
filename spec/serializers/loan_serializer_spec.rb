require 'rails_helper'

RSpec.describe LoanSerializer, type: :serializer do
  let(:loan) { Fabricate(:loan) }
  let(:serializer) { described_class.new(loan) }

  describe '#as_json' do
    let(:result) { serializer.as_json }

    it 'returns loan attributes' do
      expected = {
        loan: {
          id: loan.id,
          funded_amount: loan.funded_amount,
          outstanding_balance: loan.outstanding_balance,
          created_at: loan.created_at,
          updated_at: loan.updated_at
        }
      }
      expect(result.to_json).to be_json_eql(expected.to_json)
    end
  end
end
