module Spree
  module Admin
    class AlgoliaSettingsController < Spree::Admin::BaseController
      def show
      end

      def runner
        Spree::AlgoliaSetting.product_reindexer
        flash[:success] = Spree.t(:algolia_web_reindex_response)
        redirect_to :back
      end
    end
  end
end
