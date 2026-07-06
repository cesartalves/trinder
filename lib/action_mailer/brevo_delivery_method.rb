module ActionMailer
  class BrevoDeliveryMethod
    def initialize(_settings = {})
    end

    def deliver!(mail)
      config = Brevo::Configuration.new
      config.api_key["api-key"] = ENV.fetch("BREVO_API_KEY")

      api_instance = Brevo::TransactionalEmailsApi.new(config)

      recipients = Array(mail.to).map { |email| { email: email } }

      sender = {
        email: ENV.fetch("MAILER_FROM_EMAIL"),
        name: ENV.fetch("MAILER_FROM_NAME", "Trinder")
      }

      email = Brevo::SendSmtpEmail.new(
        sender: sender,
        to: recipients,
        subject: mail.subject,
        html_content: mail.html_part&.body&.decoded || mail.body.decoded,
        text_content: mail.text_part&.body&.decoded
      )

      api_instance.send_transac_email(email)
    end
  end
end