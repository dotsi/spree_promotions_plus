
module Spree
  class Promotion::Rules::OrderTotal < PromotionRule
    preference :amount, :decimal, :default => 100.00
    preference :operator, :string, :default => '>'

    attr_accessible :preferred_amount, :preferred_operator

    OPERATORS = ['gt', 'gte']

    def eligible?(order, options = {})
      user = order.try(:user) || options[:user]
			item_total = user.orders.complete.map(&:total).sum
      item_total.send(preferred_operator == 'gte' ? :>= : :>, BigDecimal.new(preferred_amount.to_s))
    end
  end
end