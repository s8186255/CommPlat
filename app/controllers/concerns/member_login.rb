# encoding: utf-8

module MemberLogin
  extend ActiveSupport::Concern
  included do

    protected
    def login?
      token=params[:token]
      puts token+"--hello client token"
      if token.nil?
        return false
      else
        current_member = Member.authenticate token: token
        if current_member
          return true
        else
          return false
        end
      end
    end

    def authenticate_member!
      puts login?
      unless login?
        render json: {login: false}
      else
        render json: {login: true}
      end
    end


    def current_member
      Member.find_by token: params[:token]
      #Member.find_by id: session[:member_id]
    end


    def authenticate opts
      #返回false或者member
      member = Member.authenticate opts
      if member
        render json: {token: member.token}
      else
        render json: {token: false}
      end
    end
  end

end
