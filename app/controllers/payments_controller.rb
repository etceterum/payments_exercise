class PaymentsController < ApiController
  def create
    create_params = params.require(:payment).permit(:amount)
    # Note: No explicit error checking is done in the line below because
    # both error locating the loan record and error creating the payment record
    # are handled in rescue blocks of the base ApiController
    render json: find_loan.payments.create!(create_params), status: :created
  end

  def index
    render json: find_loan.payments
  end

  def show
    render json: Payment.find(params[:id])
  end

  private

  def find_loan
    Loan.find(params[:loan_id])
  end
end
