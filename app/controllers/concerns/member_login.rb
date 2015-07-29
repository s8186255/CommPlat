# encoding: utf-8

module MemberLogin
  extend ActiveSupport::Concern
  included do

    protected
    def login?
      token=params[:token]
      if token.nil?
        return false
      else
        current_member = Member.find_by token: token
        if current_member.nil?
          return false
        else
          return true
        end
      end
    end

    def authenticate_member!
      unless login?
        render json:{login: false}
      else
        render json:{login: true}
      end
    end




    def current_member
      Member.find_by token: params[:token]
      #Member.find_by id: session[:member_id]
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
