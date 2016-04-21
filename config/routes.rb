RailsAppcache::Engine.routes.draw do
  get ':manifest-:version-:optional_param.appcache' => 'manifests#show', format: 'appcache', constraints: { version: /[a-zA-Z0-9.]+/, optional_param: /[a-zA-Z0-9.]+/ }
end
