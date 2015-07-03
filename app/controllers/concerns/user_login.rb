# encoding: utf-8

module UserLogin
  extend ActiveSupport::Concern
  included do

    protected
    def login?
      !session[:user_id].nil?
    end

    def authenticate_member!
      unless login?
        redirect_to 'login'
      end
    end

    def authenticate opts
      member = Member.authenticate opts
      if member.nil?
        redirect_to failed_members_url
      else
        session[:user_id] = member.id
      end
    end
  end

end
