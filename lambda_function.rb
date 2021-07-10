# frozen_string_literal: true

require 'json'
require 'aws-sdk-dynamodb'

# rubocop:disable Lint/UnusedMethodArgument
def execute(event:, context:)
  # rubocop:enable Lint/UnusedMethodArgument
  event['events'].each { |e| put_event(e) }
  { execute_status: 'ok' }
end

def put_event(_event)
  e.store('created_at', Time.now.to_s)
  item = {
    table_name: ENV['TABLE_NAME'],
    item: e
  }
  dynamo_client.put_item(item)
end

def dynamo_client
  Aws::DynamoDB::Client.new(
    region: ENV['REGION'],
    credentials: credentials
  )
end

def credentials
  Aws::Credentials.new(
    ENV['ACCESS_KEY_ID'],
    ENV['SECRET_ACCESS_KEY']
  )
end
