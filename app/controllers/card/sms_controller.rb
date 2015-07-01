require 'digest/md5'
require "base64"
require 'openssl'
require "rest_client"
class Card::SmsController < Card::BaseController
  layout false
  #before_action :check_unique_mobile, only: :deliver
  after_action :save_sms_log, only: :deliver

  def deliver
    reuslt = send_sms
    render json: send_sms
  end

  private
  def save_sms_log
    SmsLog.create(mobile: params[:mobile], text: params[:text], status: params[:status])
  end

  #def code
    #SecureRandom.random_number.to_s.slice(-6..-1)
  #end

  def send_sms(mobile, text)
    #rails_config gem 配置
    accountSid = Settings.sms.accountSid
    appId = Settings.sms.appId
    auth_token = Settings.sms.auth_token
    templateId = Settings.sms.templateId
    time_out = Settings.sms.time_out
    apiurl = Settings.sms.apiurl
    now_time = Time.now.strftime('%Y%m%d%H%M%S')

    authorization =  Base64.encode64("#{accountSid}:#{now_time}").delete("\n")

    sig_parameter=Digest::MD5.hexdigest("#{accountSid}#{auth_token}#{now_time}").upcase
    RestClient.post "#{apiurl}/2013-12-26/Accounts/#{accountSid}/SMS/TemplateSMS?sig=#{sig_parameter}",
      "{'to': '#{mobile}','appId': '#{appId}','templateId':'#{templateId}','datas':['#{text}']}",
      content_type: :json,
      accept: :json,
      charset: 'utf-8',
      Authorization: authorization


  end
end
