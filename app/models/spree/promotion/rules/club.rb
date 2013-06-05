
module Spree
  class Promotion::Rules::Club < PromotionRule

    def eligible?(order, options = {})
      return false if order.user.blank?
      return false unless order.user.respond_to?(:club?)

      order.user.club?
    end
  end
end
