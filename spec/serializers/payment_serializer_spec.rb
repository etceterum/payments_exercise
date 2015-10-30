require 'rails_helper'

RSpec.describe PaymentSerializer, type: :serializer do
  let(:payment) { Fabricate(:payment) }
  let(:serializer) { described_class.new(payment) }

  describe '#as_json' do
    let(:result) { serializer.as_json }

    it 'returns payment attributes' do
      expected = {
        payment: {
          id: payment.id,
          loan_id: payment.loan.id,
          amount: payment.amount,
          created_at: payment.created_at
        }
      }
      expect(result.to_json).to be_json_eql(expected.to_json)
    end
  end
end
