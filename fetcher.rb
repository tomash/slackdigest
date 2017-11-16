require 'slack'

# ENV['SLACK_API_TOKEN'] = "xoxp-999999"

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
end

client = Slack::Web::Client.new
client.auth_test

channels = client.channels_list.channels

# puts channels.inspect
readme_channel = channels.detect { |c| c.name == 'readme' }

puts "readme_channel: #{readme_channel.inspect}"

puts "client.channels_info: #{client.channels_info(channel: readme_channel.id).inspect}"


since_time = Time.parse("2017-11-01 00:00:01")

# conversations_history.messages: by default last 100 messages, sorted in reverse chronological (first=newest)

# last_message = client.conversations_history(channel: readme_channel.id).messages.first
messages = client.conversations_history(channel: readme_channel.id).messages

messages.each do |message|
  # convert message timestamp number to Ruby Time instance
  message_time =  Time.at(message.ts.to_f)
  # url added to message is in attachment
  attachment = message.attachments.to_a[0]
  next if attachment.nil?

  # puts "attachment.from_url: #{attachment.from_url}"
  # puts "attachment.title: #{attachment.title}"
  # puts "attachment.text: #{attachment.text}"

  description = ""
  description << attachment.title.to_s.strip
  description << attachment.text.to_s.strip if(description.blank?)

  attachment_text = "#{attachment.from_url} -- #{description}"
  puts message.inspect
  puts attachment_text
end


