Spree::Taxon.class_eval do
  def name_for_select(descendent = nil)
    self.name + " "+ self.permalink
    
    #if self.parent_id.blank?
    #	descendent ? descendent.name : self.name
    #else
    #	'- '+self.parent.name_for_select(descendent ? descendent : self)
    #end
  end

end
