# config/initializers/brevo_delivery.rb

require Rails.root.join("lib/action_mailer/brevo_delivery_method")

ActionMailer::Base.add_delivery_method :brevo, BrevoDeliveryMethod

Rails.application.config.action_mailer.delivery_method = :brevo