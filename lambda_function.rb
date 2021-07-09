require 'json'

def execute(event:, context:)
  Dotenv.load
  event["events"].each { |e| put_event(e) }
  { execute_status: "ok" }
end

private

def put_event(e)
  e.store("created_at", Time.now.to_s)
  item = {
    table_name: ENV['TABLE_NAME'],
    item: e,
  }
  dynamo_client.put_item(item)
end

def dynamo_client
  Aws::DynamoDB::Client.new(
    region: ENV['REGION'],
    credentials: credentials,    
  )
end

def credentials
  Aws::Credentials.new(
    ENV['ACCESS_KEY_ID'],
    ENV['SECRET_ACCESS_KEY'],
  )
end