require 'slack-notifier'

class SlackNotificationWorker
  include Sidekiq::Worker

  def perform(order_number)
    order = Spree::Order.find_by_number(order_number)
    #notifier = Slack::Notifier.new "https://hooks.slack.com/services/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", channel: "orders", username: "notifier"
    notifier = Slack::Notifier.new ENV['SLACK_WEBHOOK_URL'], channel: ENV['SLACK_ORDER_CHANNEL'], username: "rails-notifier"
    notifier.ping order.slack_notification_message
    #notifier = Slack::Notifier.new(ENV['SLACK_TEAM_NAME'], ENV['SLACK_CHANNEL_TOKEN'])
    #notifier.ping(order.slack_notification_message, channel: ENV['SLACK_CHANNEL_NAME'])
  end
end