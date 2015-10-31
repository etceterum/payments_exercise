require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  let(:loan) { Fabricate(:loan) }

  describe '#create' do
    let(:create_params) { { format: :json, payment: { amount: loan.funded_amount/2 } } }

    it 'responds with a 200' do
      get :create, create_params.merge(loan_id: loan.id)
      expect(response).to have_http_status(:ok)
    end

    context 'if the loan is not found' do
      it 'responds with a 404' do
        get :create, create_params.merge(loan_id: loan.id + 1)
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'if amount is invalid' do
      let(:invalid_create_params) { { loan_id: loan.id, format: :json, payment: { amount: -100 } } }
      it 'responds with a 400' do
        get :create, invalid_create_params
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns validation errors' do
        expected = {
          errors: {
            amount: [ "must be greater than 0" ]
          }
        }
        get :create, invalid_create_params
        expect(response.body).to be_json_eql(expected.to_json)
      end
    end
  end

  describe '#index' do
    it 'responds with a 200' do
      get :index, loan_id: loan.id
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    let(:payment) { Fabricate(:payment) }

    it 'responds with a 200' do
      get :show, id: payment.id
      expect(response).to have_http_status(:ok)
    end

    context 'if the payment is not found' do
      it 'responds with a 404' do
        get :show, id: payment.id + 1
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
