class NotificationSms
  require 'sib-api-v3-sdk'
  # setup authorization
  SibApiV3Sdk.configure do |config|
    # Configure API key authorization: api-key
    config.api_key['api-key'] = ENV['MAILER_EMAIL']
  end
  def send_sms(recipient,name)
    api_instance = SibApiV3Sdk::TransactionalSMSApi.new

    send_transac_sms = SibApiV3Sdk::SendTransacSms.new(
      'sender'=> '5562982651478',
      'recipient'=>recipient,
      'content'=> "Nome do solicitante:#{name} <br> Email cadastrado: '#{recipient}' <br> Cadastro realizado com sucesso!  "
    )

    begin
      #Send SMS message to a mobile number
      result = api_instance.send_transac_sms(send_transac_sms)
      p result
    rescue SibApiV3Sdk::ApiError => e
      puts "Exception when calling TransactionalSMSApi->send_transac_sms: #{e}"
    end

  end

end
