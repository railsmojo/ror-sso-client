require 'omniauth-oauth2'
module OmniAuth
  module Strategies
    class Sso < OmniAuth::Strategies::OAuth2

      option :client_options, {
        :site =>  ENV['SSO_PROVIDER_URL'],
        :authorize_url => "#{ENV['SSO_PROVIDER_URL']}/auth/sso/authorize",
        :access_token_url => "#{ENV['SSO_PROVIDER_URL']}/auth/sso/access_token"
      }

      uid do
        raw_info['id']
      end

      info do
        {
          :email => raw_info['info']['email']
        }
      end

      extra do
        {
          :first_name => raw_info['extra']['first_name'],
          :last_name  => raw_info['extra']['last_name']
        }
      end

      def raw_info
        @raw_info ||= access_token.get("/auth/sso/user.json?oauth_token=#{access_token.token}").parsed
      end
    end
  end
end