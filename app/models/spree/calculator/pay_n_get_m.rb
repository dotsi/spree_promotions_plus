module Spree
	class Calculator::PayNGetM < Calculator
		preference :to_pay, :integer, :default => 1
		preference :to_get, :integer, :default => 1
		preference :product_group_id, :integer, :default => nil

		attr_accessible :preferred_to_get, :preferred_to_pay, :preferred_product_group_id

		def self.description
			I18n.t(:pay_n_get_m)
		end

		def compute(object=nil)
			return 0 if object.nil?
			return 0 if preferred_to_get.blank? || preferred_to_pay.blank? || preferred_product_group_id.blank?
			return 0 if preferred_to_get <= preferred_to_pay

			sum = 0.0
			product_group = Spree::ProductGroup.find preferred_product_group_id

			object.line_items.each do |line_item|
				if product_group.products.map(&:id).include?(line_item.variant.product_id) 
					groups = (line_item.quantity / preferred_to_get).to_i
					discount_per_group = (preferred_to_get - preferred_to_pay) * line_item.price

					sum += groups * discount_per_group
				end
			end

			sum
		end

	end
end
