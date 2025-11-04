module Passkit
  class UrlGenerator
    include Passkit::Engine.routes.url_helpers

    def initialize(pass_class, generator = nil, collection_name = nil)
      @url = passes_api_url(host: ENV["PASSKIT_WEB_SERVICE_HOST"],
        payload: PayloadGenerator.encrypted(pass_class, generator, collection_name))
    end

    def ios
      @url
    end

    def android
      @url
    end
  end
end
