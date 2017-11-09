require 'slack'

ENV['SLACK_API_TOKEN'] = "xoxp-999999"

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
end

client = Slack::Web::Client.new
client.auth_test

channels = client.channels_list.channels

# puts channels.inspect
readme_channel = channels.detect { |c| c.name == 'readme' }

puts readme_channel.inspect

last_message = client.conversations_history(channel: readme_channel.id).messages.first

puts Time.at(last_message.ts.to_f)
