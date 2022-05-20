require 'pismo'
class UpdateTitleJob < ApplicationJob
  queue_as :default

  def perform(short_url_id)
    short_url = ShortUrl.find(short_url_id)
    title = get_url_title(short_url.full_url)
    short_url.title = title
    short_url.save!
  end
end
