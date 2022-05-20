require 'pismo'
class UpdateTitleJob < ApplicationJob
  queue_as :default

  def perform(short_url_id)
    short_url = ShortUrl.find(short_url_id)
    doc = Pismo::Document.new(short_url.full_url)
    title = doc.title
    short_url.title = title
    short_url.save!
  end
end
