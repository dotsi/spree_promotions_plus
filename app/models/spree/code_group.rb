module Spree
  class CodeGroup < ActiveRecord::Base
    attr_accessible :limit, :name, :promotion_id
    
    has_many :promotion_codes
    belongs_to :promotion_codes

    validates :name, :presence => true 

  end
end