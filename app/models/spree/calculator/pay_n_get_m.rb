module Spree
	class Calculator::PayNGetM < Calculator
		preference :to_pay, :integer, :default => 1
		preference :to_get, :integer, :default => 1
		preference :taxon, :integer, :default => 0

		attr_accessible :preferred_to_get, :preferred_to_pay, :preferred_taxon

		def self.description
			I18n.t(:pay_n_get_m)
		end

		def compute(object=nil)
			return 0 if object.nil?
			return 0 if preferred_to_get.blank? || preferred_to_pay.blank? || preferred_taxon == 0
			return 0 if preferred_to_get <= preferred_to_pay

			sum = 0.0
			tx = Spree::Taxon.find preferred_taxon

			object.line_items.each do |line_item|
				if tx.products.map(&:id).include?(line_item.variant.product_id) 
					txs = (line_item.quantity / preferred_to_get).to_i
					discount_per_taxon = (preferred_to_get - preferred_to_pay) * line_item.price

					sum += txs * discount_per_taxon
				end
			end

			sum
		end

	end
end
