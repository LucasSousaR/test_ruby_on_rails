class NotificationMailer < ApplicationMailer
  default from: ENV['MAILER_EMAIL']
  layout 'mailer'

  def send_link(recipient, name, title)

    mail(
        to: recipient,
        subject: title,
        body: "Nome do solicitante:#{name} <br> Email cadastrado: '#{recipient}' <br> Cadastro realizado com sucesso!  ",
        content_type: 'text/html'
    )
  end

end
