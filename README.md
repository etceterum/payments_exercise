# Payments Exercise

## Objective

Add in the ability to create payments for a given loan using a JSON API call. You should store the payment date and amount. Expose the outstanding balance for a given loan in the JSON vended for `LoansController#show` and `LoansController#index`. The outstanding balance should be calculated as the `funded_amount` minus all of the payment amounts.

A payment should not be able to be created that exceeds the outstanding balance of a loan. You should return validation errors if a payment can not be created. Expose endpoints for seeing all payments for a given loan as well as seeing an individual payment.

## Implementation Notes

As requested, the repo was [duplicated](https://help.github.com/articles/duplicating-a-repository/) instead of forking so that it is not trackable from the original repo.

For this assignment, I tried to be more verbose in comments than usual and explain some trivial things I normally don't do - just so whoever evaluates it can better understand why certain decisions were made.

I tried to focus on the objective stated above and not fix the code that pre-existed (e.g., I did not add any validations to the Loan class and didn't add any tests for that class). Instead, in places where I saw an opportunity for improvement, I'd add a comment documenting such opportunity. If fixing the existing code was a hidden objective, please let me know and I will fill that gap.

## Usage Examples

Create Payment
```
curl -XPOST -H 'Content-Type: application/json' http://localhost:3000/loans/1/payments -d '{"payment": {"amount": 100}}'
```

Get specific Payment by ID
```
curl -XGET http://localhost:3000/payments/1
```

Get all Payments on a given Loan
```
curl -XGET http://localhost:3000/loans/1/payments
```

## TODOs
* Back-fill missing validations and constraints on the Loan class? Add specs?
* LoansController#index has an N+1 problem after adding outstanding_balance
