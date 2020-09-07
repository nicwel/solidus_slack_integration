require 'slack-notifier'

class SlackNotificationWorker
  include Sidekiq::Worker

  def perform(order_number)
    order = Spree::Order.find_by_number(order_number)
    notifier = Slack::Notifier.new ENV['SLACK_WEBHOOK_URL'], channel: ENV['SLACK_ORDER_CHANNEL'], username: "rails-notifier"
    if order # avoid order.state called on nil error
      notifier.ping "Received order: #{order_number} #{order.state} #{order.email} #{order.name} #{order.amount}" # order.slack_notification_message
    else
      notifier.ping "Received order: #{order_number}"
    end
  end
end
