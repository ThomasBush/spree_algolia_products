module Spree
  module Api
    module V1
      class AlgoliaSettingsController < Spree::Api::BaseController
        def runner
          Spree::AlgoliaSetting.product_reindexer
          render status: 200, json: {message: Spree.t(:algolia_api_reindex_response)}
        end
      end
    end
  end
end
