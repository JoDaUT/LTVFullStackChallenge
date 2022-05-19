class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
    # return all short urls from database
    # @short_urls = ShortUrl.all
    # render json: @short_urls
    render json:"hello world"
  end

  def create
  end

  def show
    render json:"hello world2"
  end

end
