class Apiv2MailJob < ActiveJob::Base
  queue_as :default

  def perform()
    subs = {
        '%name%': ["name"],
    }
    vars = JSON.dump({"to" => [Figaro.env.mail_to_email], "sub" => subs})

    response = RestClient.post Figaro.env.apiv2_mail_template,
                               apiUser: Figaro.env.mail_user_name, # 使用api_user和api_key进行验证
                               apiKey: Figaro.env.mail_service_key,
                               from: Figaro.env.mail_form, # 发信人，用正确邮件地址替代
                               to: Figaro.env.mail_to_email,
                               templateInvokeName: "test_template_send",
                               subject: "TEST SendCloud",
                               xsmtpapi: vars,
                               timeout: 10,
                               open_timeout: 10

    Rails.logger.info(response)
    # {"result":false,"statusCode":40005,"message":"认证失败","info":{}}
  end
end
