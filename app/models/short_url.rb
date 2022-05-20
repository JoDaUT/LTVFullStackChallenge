require 'uri'
require 'base62-rb'

include ShortUrlsHelper
class ShortUrl < ApplicationRecord

  validate :validate_full_url
  validates :full_url, presence: true
  
  def short_code
    Base62.encode(self.id)
  end

  def update_title!
    self.title = get_url_title(self.full_url)
  end

  private

  def validate_full_url
    errors.add(:full_url, "is not a valid url") if (self.full_url =~ URI::regexp(%w[http https])) == nil
  end

end
