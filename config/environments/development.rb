Rails.application.configure do
  config.action_controller.perform_caching = false
  config.active_record.migration_error = :page_load
  config.active_support.deprecation = :log
  config.assets.debug = true
  config.assets.quiet = true
  config.cache_classes = false
  config.cache_store = :null_store
  config.consider_all_requests_local = true
  config.eager_load = false
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.seconds.to_i}"
    }
  end
end
