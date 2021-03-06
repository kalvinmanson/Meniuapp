class Admin::PaymentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.all
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(payment_params)
    if @payment.save
      redirect_to admin_payment_path(@payment), notice: 'Payment was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
      if @payment.update(payment_params)
        redirect_to admin_payment_path(@payment), notice: 'Payment was successfully updated.'
      else
        render :edit
      end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    redirect_to admin_payments_url, notice: 'Payment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:user_id, :place_id, :months, :total, :status)
    end
end
