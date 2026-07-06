require Rails.root.join("lib/action_mailer/brevo_delivery_method")

ActionMailer::Base.add_delivery_method(
  :brevo,
  ActionMailer::BrevoDeliveryMethod
)

Rails.application.config.action_mailer.delivery_method = :brevo