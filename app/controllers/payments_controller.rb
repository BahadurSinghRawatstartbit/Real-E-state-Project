# app/controllers/payments_controller.rb
class PaymentsController < ApplicationController
  # before_action :superuser 
  def new
    #@book = current_user.books.find(params[:book_id])
  end
  
    

  def index
    @payment_intents = Stripe::PaymentIntent.list(limit: 10)
    @charges         = Stripe::Charge.list(limit: 10)
    @refunds         = Stripe::Refund.list(limit: 10)
    @customers       = Stripe::Customer.list(limit: 10)
    @invoices        = Stripe::Invoice.list(limit: 10)
    @subscriptions   = Stripe::Subscription.list(limit: 10)
  end



  def create
    @book = current_user.books.find(params[:book_id])

    line_items = @book.booking_items.includes(:property).map do |item|
      booking_price = (item.property.price.to_f * 0.10 * 100).to_i

      {
        price_data: {
          currency: 'usd',
          product_data: {
            
            name: item.property.name,
            
            description: "Actual Price for #{item.property.price}",
            images: item.property.images.attached? ? [url_for(item.property.images.first)] : []
          },
          unit_amount: booking_price
        },
        quantity: item.quantity
      }
    end

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: line_items,
      mode: 'payment',
      success_url: success_payments_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: new_payments_url,
      customer_email: current_user.email
    )

    

    redirect_to session.url, allow_other_host: true
  end


 

def success
  @session = Stripe::Checkout::Session.retrieve(params[:session_id])

  @email=current_user.email
  @newbook= current_cart
  @book= current_user.books.find(@newbook.id)
  
  @payment_intent_id = @session.payment_intent

  @payment_intent = Stripe::PaymentIntent.retrieve(@payment_intent_id)

  @transaction_id = @payment_intent.latest_charge


  unless @book.id
    redirect_to root_path, alert: "Booking not found"
    return
  end

  @properties_sold = @book.booking_items.includes(:property).map(&:property)

  @book.update!(status: 'sold')
 
  UserMailer.payment_receipt(@email,@book,@payment_intent_id).deliver_now
end



  def cancel
  end
end
