require 'uri'

class SlackNotifier
  attr_accessor :webhook_url

  def initialize(webhook_url:)
    if webhook_url.present?
      self.webhook_url = URI.parse(webhook_url)
    end
  end

  def notify(message)
    unless Rails.env.production?
      Rails.logger.info("[SLACK_NOTIFIER]#{message}")
      return
    end

    RestClient.api_request(
      method: :post,
      domain: webhook_url.host,
      scheme: webhook_url.scheme,
      port: webhook_url.port,
      path: webhook_url.path,
      body_params: {
        text: message,
      },
      headers: {
        'Content-Type': 'application/json',
      },
      is_json: false,
    )
  end
end
