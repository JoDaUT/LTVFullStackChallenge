require 'uri'
require 'base62-rb'

include ShortUrlsHelper
class ShortUrl < ApplicationRecord
  include ActiveModel::Dirty

  after_save :update_short_code
  after_create :update_short_code
  after_commit :update_short_code
  after_update :update_short_code

  validate :validate_full_url
  validates :full_url, presence: true
  def short_code
    if self[:short_code] != nil && self[:short_code] != Base62.encode(self.id)
      self[:short_code] = Base62.encode(self.id)
    end
    return self[:short_code]
  end

  def update_title!
    self.title = get_url_title(self.full_url)
  end

  private

  def validate_full_url
    errors.add(:full_url, "is not a valid url") if (self.full_url =~ URI::regexp(%w[http https])) == nil
  end

  def update_short_code
    if self[:short_code] == nil || (self[:short_code] != nil && self.id_changed?)
      self[:short_code] = Base62.encode(self.id)
      self.save!
    end
  end

  
end

