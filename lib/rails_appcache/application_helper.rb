module RailsAppcache
  module ApplicationHelper
    def appcache_manifest_path(path)
      return "" unless RailsAppcache.config.perform_caching?

      "/#{path}-#{appcache_version_string}#{'-' + appcache_optional_param}.appcache"
    end

    # In development, serve up a new manifest every time
    # In production, serve the current Git revision
    def appcache_version_string
      RailsAppcache.config.version
    end

    def appcache_optional_param
      opts = { env: request.env }
      RailsAppcache.config.optional_param_getter.new(opts).get.to_s
    end

    def stylesheet_cache_path(*paths)
      tags = stylesheet_link_tag(*paths)
      tags.scan(/href="(.*?)"/).map do |match|
        match[0].html_safe
      end.join("\n")
    end

    def javascript_cache_path(*paths)
      tags = javascript_include_tag(*paths)
      tags.scan(/src="(.*?)"/).map do |match|
        match[0].html_safe
      end.join("\n")
    end

    def asset_cache_path(path)
      asset_path(path)
    end
  end
end
