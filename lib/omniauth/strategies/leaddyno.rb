require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Leaddyno < OmniAuth::Strategies::OAuth2
      option :name, "leaddyno"

      option :client_options, {
          :site          => 'https://app.leaddyno.com',
          :authorize_url => '/oauth/authorize',
          :token_url     => '/oauth/access_token'
      }

      uid{ raw_info['payload']['id'] }

      info do
        {
            :email => raw_info['payload']['email'],
        }
      end

      extra do
        {
            'raw_info' => raw_info['payload']
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/v1/account/info').parsed
      end
    end
  end
end