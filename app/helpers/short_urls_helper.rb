require 'pismo'
module ShortUrlsHelper

    def get_url_title(url)
        doc = Pismo::Document.new(url)
        return doc.title
    end
end
