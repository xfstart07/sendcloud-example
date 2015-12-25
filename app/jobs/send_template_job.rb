class SendTemplateJob < ActiveJob::Base
  queue_as :default

  #http://sendcloud.sohu.com/doc/email/send_email/#_2
  def perform()
    subs = {
        '%name%': ["name"],
    }
    vars = JSON.dump({"to" => [Figaro.env.mail_to_email], "sub" => subs})

    response = RestClient.post Figaro.env.mail_template_url,
                               api_user: Figaro.env.mail_user_name, # 使用api_user和api_key进行验证
                               api_key: Figaro.env.mail_service_key,
                               from: Figaro.env.mail_form, # 发信人，用正确邮件地址替代
                               substitution_vars: vars,
                               template_invoke_name: "test_template_send",
                               subject: "TEST SendCloud",
                               resp_email_id: true
    Rails.logger.info(response)
  end
end
