class UserMailer < ApplicationMailer
    default from: "noreply@example.com'"

   

  def password_reset(user, reset_token)
    @user = user
    @reset_token = reset_token
    @reset_url = "#{ENV['MAILER_HOST']}/password_reset?token=#{reset_token}"
    
    mail(
      to: user.email,
      subject: 'Password Reset Request'
    )
  end
  
 
  def welcome_email(user)
    @user = user
    
    mail(
      to: user.email,
      subject: 'Welcome to Our E-commerce Store!'
    )
  end
  
  
  def subscription_confirmation(email)
    @email = email
    
    mail(
      to: email,
      subject: 'Thanks for Subscribing!'
    )
  end

  def order_confirmation(order)
    @order = order
    @user = order.user
    
    mail(
      to: order.email,
      subject: "Order Confirmation - #{order.order_number}"
    )
  end
  
  

  def payment_receipt(email,book,payment_intent_id)
    @book = book
    @payment_intent_id = payment_intent_id
    mail(
      to: email,
      subject: "Payment Receipt Booking sdi}"
    )
  end

  def contact_form_submission(name, email, subject, message)
    @name = name
    @message = message
    @subject = subject
    @from_email = email

    mail(
      to: ENV['GMAIL_USERNAME'],
      subject: "Your Query For: #{@subject}",
      from: email
    )
  end
end
