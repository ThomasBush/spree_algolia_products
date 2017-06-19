module AlgoliaProductIndex
  extend ActiveSupport::Concern

  included do
    include AlgoliaSearch

    def status?
      available_on < Time.now && deleted_at.nil?
    end

    def no_image
      ActionController::Base.helpers.image_url('noimage/small.png')
    end

    algoliasearch index_name: "spree_products_#{Rails.env}", if: :status? do
      attribute :id, :position, :name, :code

      attribute :url do
        "/products/#{slug}"
      end

      attribute :image do
        if images.present?
          images.first.attachment.url(:small)
        elsif variants.first.images.first.present?
          variants.first.images.first.attachment.url(:small)
        else
          no_image
        end
      end

      attribute :price do
        display_price.to_html.gsub('$','')
      end

      attribute :product_type do
        taxons.find_by('permalink LIKE ?', 'product-types/%').name
      end

      attrs = ['size', 'yuleys_size', 'color', 'tint', 'lens_coating']

      attrs.each do |attr|
        attribute attr.to_sym do

          attribute = Spree::OptionType.find_by('name = ?', attr)
          variants.map{|v| v.option_values.where(option_type: attribute).map(&:presentation)}.flatten.uniq
        end
      end
    end
  end
end
