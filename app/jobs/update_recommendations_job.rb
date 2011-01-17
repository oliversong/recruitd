class UpdateRecommendationsJob < Struct.new(:entity_type, :entity_id)
  def perform
    entity = Kernel.const_get(entity_type).find(entity_id)
    
  end
end