# encoding: utf-8

module MemberLogin
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

    def authenticate_by_name
    end
    def authenticate_by_email

    end
def authenticate_by_token

end


    def current_member
      Member.find_by id: session[:user_id]
    end

    private
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
