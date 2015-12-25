class SendMailJob < ActiveJob::Base
  queue_as :default

  def perform()
    html = "<p>hello world</p>"

    # 普通发送一直返回的是553
    response = RestClient.post Figaro.env.mail_url,
                               api_user: Figaro.env.mail_api_user, # 使用api_user和api_key进行验证
                               api_key: Figaro.env.mail_api_key,
                               from: Figaro.env.mail_form, # 发信人，用正确邮件地址替代
                               to: Figaro.env.mail_to_email,
                               subject: "TEST",
                               html: html,
                               timeout: 10,
                               open_timeout: 10

    Rails.logger.debug(response)
  end
end
