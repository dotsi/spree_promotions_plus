
module Spree
  class Promotion::Rules::OrderQuantity < PromotionRule
    preference :quantity, :integer, :default => 10
    preference :operator, :string, :default => '>'

    attr_accessible :preferred_quantity, :preferred_operator

    OPERATORS = ['gt', 'gte']

    def eligible?(order, options = {})
    	user = order.try(:user) || options[:user]
      user.orders.complete.count.send(preferred_operator == 'gte' ? :>= : :>, preferred_quantity)
    end
  end
end
