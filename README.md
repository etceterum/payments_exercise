# Payments Exercise

## Objective

Add in the ability to create payments for a given loan using a JSON API call. You should store the payment date and amount. Expose the outstanding balance for a given loan in the JSON vended for `LoansController#show` and `LoansController#index`. The outstanding balance should be calculated as the `funded_amount` minus all of the payment amounts.

A payment should not be able to be created that exceeds the outstanding balance of a loan. You should return validation errors if a payment can not be created. Expose endpoints for seeing all payments for a given loan as well as seeing an individual payment.

## Implementation Notes

As requested, the repo was [duplicated](https://help.github.com/articles/duplicating-a-repository/) instead of forking so that it is not trackable from the original repo.

For this assignment, I tried to be more verbose in comments than usual and explain some trivial things I normally don't do - just so whoever evaluates it can better understand why certain decisions were made.

I tried to focus on the objective stated above and not fix the code that pre-existed (e.g., I did not add any validations to the Loan class and didn't add any tests for that class). Instead, in places where I saw an opportunity for improvement, I'd add a comment documenting such opportunity. If fixing the existing code was a hidden objective, please let me know and I will fill that gap.

Perhaps, I oversimplified the problem, but I made an assumption that the "created_at" timestamp on Payment model represents the date of payment. If this assumption is incorrect, it'd be trivial to add an explicitly managed separate timestamp to the Payment model.

I used ActiveModelSerializers gem for formatting models as JSON, as this way is preferred by the Rails community to using `as_json` on the model, and is overall more flexible and powerful; in fact, it is part of Rails 5.

Please check the note next to `outstanding_balance` inside `loan_serializer.rb` regarding efficiency. I did not implement the solution to the (N + 1) query problem in this assignment because I am not aware of any _elegant_ solution, and I didn't want my code to look heavy or ugly for obvious reasons. The two potential database solutions to the mentioned N + 1 problem would be to either perform the sum calculation in a database view, or to use custom SQL to fetch data. I can implement either approach on request.
Alternatively, it'd be possible to eliminate the (N + 1) query by transferring the calculations into the application space from the 
database space like so: 
```Ruby
loans = Loan.eager_load(:payments).all
for loan in loans
	# this won't cause extra trips to the database!
	outstanding_balance = loan.funded_amount - loan.payments.map(&:amount).sum
end
```
However, this could potentially cause memory overflow if the count of loans in the database is high and no proper pagination is implemented.

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
