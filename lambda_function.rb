require "json"
require "aws-sdk-dynamodb"

def execute(event:, context:)    
  return { execute_status: "ok", context: event }
end
