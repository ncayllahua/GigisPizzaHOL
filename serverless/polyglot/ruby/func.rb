# frozen_string_literal: true

require 'fdk'
require './ords_service'

def upload_discount(context:, input:)
  r = OrdsService.new(
    base_url: ENV['DB_ORDS_BASE'],
    token_url_suffix: ENV['DB_ORDS_SERVICE_OAUTH'],
    service_url_suffix: ENV['DB_ORDS_SERVICE'],
    client_id: ENV['DB_ORDS_CLIENT_ID'],
    client_secret: ENV['DB_ORDS_CLIENT_SECRET']
  ).write(data: input)

  { status: r.status, message: r.reason_phrase }
end

FDK.handle(target: :upload_discount)
