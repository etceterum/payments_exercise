class LoanSerializer < ActiveModel::Serializer
  attributes :id
  attributes :funded_amount, :outstanding_balance
  attributes :created_at, :updated_at
end
