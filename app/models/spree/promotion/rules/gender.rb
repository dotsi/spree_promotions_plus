
module Spree
  class Promotion::Rules::Gender < PromotionRule
  	preference :gender, :string, :default => 'm'

  	attr_accessible :preferred_gender

    def eligible?(order, options = {})
      return false if order.user.blank?
      return false if order.user.gender.blank?

      order.user.gender == preferred_gender
    end
  end
end
