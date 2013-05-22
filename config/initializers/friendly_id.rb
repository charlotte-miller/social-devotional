FriendlyId.defaults do |config|
  config.use :slugged, :history
  config.use :reserved
    # Reserve words for English and Spanish URLs
    config.reserved_words = %w(new edit nueva nuevo editar search library groups info studies about bible books audio video)
end
