class LinksController < ApplicationController
  def index
    # get most recent 50 so we don't worry about
    # dataset getting too big for now 
    @links = Link.last(50).reverse
  end

  def create
    @link = Link.find_by(link_params)
    if @link.nil?
      @link = Link.new(link_params)
      @link.token = generate_unique_token
      @link.save
    end
    respond_to :js
  end

  # SecureRandom.hex generates a random hexadecimal string.
  # 3 bytes creates 6 hex characters
  # which means we have 6^16 ~ 16.7 million unique combinations
  # this strategy will quickly have to be updated if 
  # more than a couple million of tokens is expected to be
  # created
  def generate_unique_token
    token = SecureRandom.hex(3)
    while Link.find_by(token: token)
      token = SecureRandom.hex(3)
    end
    token
  end

  def visit_link
    link = Link.find_by(token: params[:token])

    if link
      visit = Visit.new
      visit.ip_addr = request.remote_ip
      visit.link = link
      visit.save
      redirect_to link.url
    else
      render :file => "#{Rails.root}/public/404.html",
        layout: false, status: :not_found
    end
  end

  def link_info
    @link = Link.find_by(token: params[:token])
    if @link 
      # get most recent 50 so we don't worry about
      # dataset getting too big for now 
      @visits = @link.visits.last(50).reverse
    else
      render :file => "#{Rails.root}/public/404.html",
        layout: false, status: :not_found
    end
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end
end
