class ApplicationController < ActionController::Base
  before_action :authenticate_sso_user

  def authenticate_sso_user
    if !current_user
      respond_to do |format|
        format.html  {
          # redirect_to '/auth/sso' # Omniauth doesn't support GET request right now, so normal redirection will not work in this case and it will get a routing error. That's why repost gem is reuqired to redirect users using POST method.
          repost('auth/sso', options: {authenticity_token: :auto})
        }
        format.json {
          render :json => { 'error' => 'Access Denied' }.to_json
        }
      end
    end
  end

  def current_user
    return nil unless session[:user_id]
    @current_user ||= User.find_by_uid(session[:user_id]['uid'])
  end
end
