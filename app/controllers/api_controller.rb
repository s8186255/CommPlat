class ApiController < ActionController::Base
  skip_before_filter :verify_authenticity_token
  include MemberLogin
end
