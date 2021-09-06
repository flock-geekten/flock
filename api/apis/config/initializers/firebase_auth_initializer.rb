FirebaseIdToken.configure do |config|
  config.redis = Redis.new
  config.project_ids = ['flock-geekten']
end
