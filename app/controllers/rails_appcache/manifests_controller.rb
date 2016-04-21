
class RailsAppcache::ManifestsController < RailsAppcache::ApplicationController
  include RailsAppcache::ApplicationHelper

  before_filter :check_caching_enabled

  def show
    if same_version? && same_optional_param?
      # This is a request from a current version of the page
      render params[:manifest]
    else
      # This is a request from an obsolete page, using an obsolete manifest
      # Serving a 404 enough to trigger an obsoletion event, which is purge
      # the manifest from the appcache.
      #
      # The client will get the correct version on the *next* page request
      display_404
    end
  end

  private

  def display_404
    render status: :not_found, text: ''
  end

  def check_caching_enabled
    display_404 unless RailsAppcache.config.perform_caching?
  end

  def same_version?
    params[:version] == appcache_version_string
  end

  def same_optional_param?
    return true unless appcache_optional_param
    params[:optional_param] == appcache_optional_param
  end
end
