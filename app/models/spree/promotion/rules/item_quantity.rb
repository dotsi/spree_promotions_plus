
module Spree
  class Promotion::Rules::ItemQuantity < PromotionRule
    preference :quantity, :integer, :default => 10
    preference :operator, :string, :default => '>'

    attr_accessible :preferred_quantity, :preferred_operator

    OPERATORS = ['gt', 'gte']

    def eligible?(order, options = {})
      item_total = order.line_items.map(&:quantity).sum
      item_total.send(preferred_operator == 'gte' ? :>= : :>, preferred_quantity)
    end
  end
end
