class Spree::AlgoliaSetting < ActiveRecord::Base
  def self.product_reindexer
    Spree::Product.reindex
  end
end
