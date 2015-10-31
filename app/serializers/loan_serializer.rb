class LoanSerializer < ActiveModel::Serializer
  attributes :id
  attributes :funded_amount
  attributes :created_at, :updated_at

  # Note on outstanding_balance:
  # Adding this attribute to serialized representation of Loan
  # implicitly creates an (N + 1) problem in situations where
  # serialization of multiple Loan objects (e.g. fetched by Loan.all)
  # is needed. The problem is that ActiveRecord::Calculations module
  # doesn't make use of eagerly loaded associations, so it'd be
  # impossible to fix the problem by adding .eager_load(:payments)
  # to Loan's scopes.
  # For more information, please see 
  # http://stackoverflow.com/questions/19462427/do-activerecordcalculations-with-eager-loading-make-multiple-database-queries
  # Also please see the relevant portion of the README file
  attributes :outstanding_balance
end
