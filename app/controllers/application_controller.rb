class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :subtract_www_subdomain

  # skip_before_filter :verify_authenticity_token

  rescue_from CanCan::AccessDenied do |exception|
    if current_user
      raise
    else
      session[:requested_url] = request.url
      redirect_to root_url, alert: t('shared.access_denied')
    end
  end

  private
    def subtract_www_subdomain
      if request.host.split('.')[0] == 'www'
        redirect_to 'https://' + request.host.gsub('www.',''), status: 301
      end
    end

end
