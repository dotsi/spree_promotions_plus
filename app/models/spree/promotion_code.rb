module Spree
  class PromotionCode < ActiveRecord::Base
    attr_accessible :code, :redeemed_at, :user_id, :code_group_id
    
    belongs_to :code_group
    belongs_to :user

    scope :redeemed, where("redeemed_at is not null")
    scope :free, where("redeemed_at is null")

    def redeemed?
    	!self.redeemed_at.blank?
    end

  end
end