module ActionMailer
  class BrevoDeliveryMethod
    def initialize(_settings = {})
    end

    def deliver!(mail)
      Brevo.configure do |config|
        config.api_key["api-key"] = ENV.fetch("BREVO_API_KEY")
      end

      api_instance = Brevo::TransactionalEmailsApi.new

      recipients = Array(mail.to).map do |email|
        Brevo::SendSmtpEmailTo.new(email: email)
      end

      sender = Brevo::SendSmtpEmailSender.new(
        email: ENV.fetch("MAILER_FROM_EMAIL"),
        name: ENV.fetch("MAILER_FROM_NAME", "Trinder")
      )

      html_content =  
        if mail.html_part
          mail.html_part.body.decoded
        else
          mail.body.decoded
        end

      email = Brevo::SendSmtpEmail.new({
        sender: sender,
        to: recipients,
        subject: mail.subject,
        htmlContent: html_content.presence || "<p>#{ERB::Util.html_escape(mail.body.decoded)}</p>",
        textContent: mail.text_part&.body&.decoded || mail.body.decoded
      })

      api_instance.send_transac_email(email)
    rescue Brevo::ApiError => e
      Rails.logger.error("Brevo API error: #{e.message}")
      Rails.logger.error("Brevo response body: #{e.response_body}") if e.respond_to?(:response_body)
      raise
    end
  end
end