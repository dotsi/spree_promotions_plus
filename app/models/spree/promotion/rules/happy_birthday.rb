
module Spree
  class Promotion::Rules::HappyBirthday < PromotionRule

    def eligible?(order, options = {})
      return false if order.user.blank?
      return false if order.user.birthdate.blank?

      order.user.birthdate == Date.today
    end
  end
end
