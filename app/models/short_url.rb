require 'uri'
include ShortUrlsHelper
class ShortUrl < ApplicationRecord

  validate :validate_full_url
  validates :full_url, presence: true
  
  def short_code
    ShortUrlsHelper::base62Encoder(self.id)
  end

  def update_title!
  end

  private

  def validate_full_url
    errors.add(:full_url, "is not a valid url") if (self.full_url =~ URI::regexp(%w[http https])) == nil
  end

end
