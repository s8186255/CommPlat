# encoding: utf-8

module MemberLogin
  extend ActiveSupport::Concern
  included do

    protected
    def login?
      !session[:member_id].nil?
    end

    def authenticate_member!
      unless login?
        redirect_to('login') || render(json:{login: 'false'})
      else
        current_member
      end
    end




    def current_member
      Member.find_by id: session[:member_id]
    end


    def authenticate opts
      member = Member.authenticate opts
      if member.nil?
        redirect_to failed_members_url
      else
        session[:member_id] = member.id
      end
    end
  end

end
