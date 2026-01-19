class ApplicationMailer < ActionMailer::Base
  default from: ENV['GMAIL_USERNAME'] || 'noreply@example.com'
  layout 'mailer'
  # default from: 'from@example.com'
  # layout 'mailer'
end
