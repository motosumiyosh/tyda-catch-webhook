# frozen_string_literal: true

require 'dotenv/load'

env_on_str = ''
Dotenv.parse('.env.stg').each do |k, v|
  env_on_str += "#{k}=#{v},"
end

puts "{#{env_on_str.chop}}"
