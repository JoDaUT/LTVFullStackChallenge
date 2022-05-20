require 'json'
include ShortUrlsHelper
require 'base62-rb'
# include UpdateTitleJob
class ShortUrlsController < ApplicationController

  skip_before_action :verify_authenticity_token

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render json: '{"error": "not_found"}', status: :not_found
  end

  def index
    @short_urls = ShortUrl.order(click_count: :desc).limit(100)
    render json: {urls:@short_urls}
  end

  def create
    params.require(:full_url)
    full_url = params[:full_url]
    short_url = ShortUrl.new
    short_url.full_url = full_url
    if !short_url.save
      flash[:alert] = 'User was not saved'
      return render json:{errors:short_url.errors.full_messages}, status: 400
    end
    short_url.short_code = Base62.encode(short_url.id)
    short_url.save!

    UpdateTitleJob.perform_later(short_url.id)
    return render json: { short_code: short_url.short_code, short_url: short_url}

  end

  def show
    id = params[:id]
    short_url = nil
    row = Base62.decode(id)
    # a transaction is used to ensure that the click_count is incremented without race conditions
    ShortUrl.transaction do
      short_url = ShortUrl.lock(true).find(row)
      short_url.click_count += 1
      short_url.save!
    end
    redirect_to short_url.full_url
  end

end
