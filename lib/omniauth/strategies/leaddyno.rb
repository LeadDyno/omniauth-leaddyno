require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Leaddyno < OmniAuth::Strategies::OAuth2

      option :client_options, {
          :site          => 'https://app.leaddyno.com',
          :authorize_url => '/oauth/authorize',
          :token_url     => '/oauth/access_token'
      }

      uid{ raw_info['id'] }

      info do
        {
            :email => raw_info['email'],
        }
      end

      extra do
        {
            'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/v1/account/info').parsed
      end
    end
  end
end