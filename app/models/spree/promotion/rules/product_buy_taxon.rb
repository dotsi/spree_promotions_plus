module Spree
	class Promotion::Rules::ProductBuyTaxon < PromotionRule
		preference :taxon, :integer, :default => ''

		attr_accessible :preferred_taxon

		def eligible?(order, options = {})
			order.line_items.any?{|line_item| line_item.product.taxons.map(&:id).include?(preferred_taxon)}
		end

	end
end
