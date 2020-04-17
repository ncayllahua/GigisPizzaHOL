# frozen_string_literal: true

require 'oauth2'

# Represents an ORDS REST endpoint.
# Provides authorization, read and write operations
class OrdsService
  attr_reader :base_url, :token_url_suffix, :service_url,
              :oauth_client

  def initialize(base_url:, token_url_suffix:, service_url_suffix:,
                 client_id:, client_secret:)
    @base_url = base_url
    @token_url_suffix = token_url_suffix
    @service_url = base_url + service_url_suffix
    @oauth_client = OAuth2::Client.new(
      client_id,
      client_secret,
      site: base_url,
      token_url: token_url_suffix,
      auth_scheme: :basic_auth
    )
  end

  def token
    @token ||= oauth_client.client_credentials.get_token.token
  end

  def service_client
    @service_client ||= begin
      conn = Faraday::Connection.new(
        service_url,
        headers: { 'Content-Type' => 'application/json' }
      )
      conn.authorization(:Bearer, token)
      conn
    end
  end

  def read
    service_client.get.body
  end

  def write(data:)
    service_client.post { |req| req.body = data.to_json }
  end
end
