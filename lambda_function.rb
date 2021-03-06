# frozen_string_literal: true

require 'json'
require 'aws-sdk-dynamodb'
require "active_support/all"

# rubocop:disable Lint/UnusedMethodArgument
def execute(event:, context:)
  # rubocop:enable Lint/UnusedMethodArgument
  event['events'].each { |e| put_event(e) }
  { execute_status: 'ok' }
end

def put_event(event)
  set_time_zone
  event.store('created_at', Time.zone.now.to_s)
  item = {
    table_name: ENV['TABLE_NAME'],
    item: event
  }
  dynamo_client.put_item(item)
end

def dynamo_client
  Aws::DynamoDB::Client.new(
    region: ENV['REGION'],
    credentials: credentials
  )
end

def set_time_zone
  Time.zone = ENV['TIMEZONE']
end

def credentials
  Aws::Credentials.new(
    ENV['ACCESS_KEY_ID'],
    ENV['SECRET_ACCESS_KEY']
  )
end
