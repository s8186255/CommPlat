# encoding: utf-8

class CommHandler
  # 通用的通讯处理类；
  # 初始化参数包括：
  #
  # url：电信能力平台的url，在settings.xml中有定义；
  # timestamp：时间戳
  # access_token：能力平台分配的接入token，表明合法性；
  # token_secret：token对应的密钥
  # req_body：请求部分；每个能力对应的请求报文是不相同的；这个是实际的传参
  #
  def initialize opts={}
    timestamp = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    access_token = Settings.comm.access_token
    token_secret = Settings.comm.token_secret
    @url = opts[:url]
    @json_params = {
        access_token: access_token,
        timestamp: timestamp,
        sign: Digest::MD5.digest(access_token + timestamp + token_secret).unpack("H*")[0],
        req_body: opts[:req_body]
    }

  end

  def group_call
    RestClient.post @url,@json_params
  end

  def group_record_call

  end

  def mass_sms

  end


end
