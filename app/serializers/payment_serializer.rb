class PaymentSerializer < ActiveModel::Serializer
  has_one :loan_id

  attributes :id
  attributes :amount
  attributes :created_at
end
